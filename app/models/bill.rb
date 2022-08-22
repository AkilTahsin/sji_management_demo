class Bill < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_many :payments, dependent: :destroy
  has_many :adjustments, dependent: :destroy
  after_validation :set_total_cost
  after_create :set_payment

  validates :liters_taken, :unit_cost, numericality: { greater_than_or_equal_to: 0.01 }

  PAYLATER = 0
  UNPAID = 1
  PAID = 2

  enum payment_status: {
    PayLater: PAYLATER,
    Unpaid: UNPAID,
    Paid: PAID
  }

  def set_total_cost
    self.total_cost = self.liters_taken * self.unit_cost
  end

  def set_payment
    if !self.PayLater?
      # update_column(payment_status, UNPAID)
      adjustment_amount = if creator.adjustment_balance >= total_cost
                            self.total_cost
                          else
                            self.creator.adjustment_balance
                          end

      # puts adjustment_amount
      self.payments.create(
        bill_amount: self.total_cost,
        adjustment_amount: adjustment_amount,
        total_amount: self.total_cost - adjustment_amount,
        status: Payment::INITIATED
      )
    elsif self.PayLater? && adjustments.LaterPayment.count.eql?(0)
      adjustments.create(
        user_id: creator_id,
        adjustment_type: Adjustment::LATERPAYMENT,
        amount: total_cost
      )
    end
  end

  validates :liters_taken, :unit_cost, :payment_status, presence: true
  validates :payment_status, inclusion: payment_statuses.keys
end
