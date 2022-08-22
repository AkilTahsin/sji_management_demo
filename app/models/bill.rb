class Bill < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :payments, dependent: :destroy
  has_many :adjustments, dependent: :destroy

  after_create :set_payment

  validates :liters_taken, :unit_cost, numericality: {greater_than_or_equal_to: 0.01}

  PAYLATER = 0
  UNPAID = 1
  PAID = 2

  enum payment_status: {
    PayLater: PAYLATER,
    Unpaid: UNPAID,
    Paid: PAID
  }

  def set_payment
    self.total_cost = self.liters_taken * self.unit_cost
    self.save
    if !self.PayLater?
      self.update(payment_status: UNPAID)
      bill_amount = self.total_cost
      adjust_amount = if self.creator.adjustment_balance >= bill_amount
        bill_amount
                      else
                        self.creator.adjustment_balance
                      end

      self.payments.create(
        bill_amount: bill_amount,
        adjustment_amount: adjust_amount,
        total_amount: bill_amount - adjust_amount,
        status: Payment::INITIATED
      )

    elsif self.PayLater? && self.adjustments.LaterPayment.count.eql?(0)
      self.adjustments.create(
        user_id: self.creator_id,
        adjustment_type: Adjustment::LATERPAYMENT,
        amount: self.total_cost
      )
    end
  end

  validates :liters_taken, :unit_cost, :payment_status, presence: true
  validates :payment_status, inclusion: payment_statuses.keys
end