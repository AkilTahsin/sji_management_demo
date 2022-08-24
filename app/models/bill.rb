class Bill < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: :user_id
  has_many :payments, dependent: :destroy
  has_many :adjustments, dependent: :destroy
  before_save :set_total_cost
  after_create :add_payment_entry

  validates :liters_taken, :unit_cost, numericality: { greater_than_or_equal_to: 0.01 }
  
  UNPAID = 0
  PAID = 1

  enum payment_status: {
    Unpaid: UNPAID,
    Paid: PAID
  }

  # Calculate total_cost from input value
  def set_total_cost
    self.total_cost = self.liters_taken * self.unit_cost
  end

  # Calculate adjustment_amount from user balance
  def get_adjustment_amount
    if self.user.adjustment_balance >= self.total_cost
      return self.total_cost
    else
      return -self.user.adjustment_balance
    end
  end

  # Bill Processing
  def add_payment_entry
    self.payment_status = UNPAID
    payment_entry = self.payments.new
    
    if self.payment_type.eql? 'paylater'                   # Process Pay-Later request
      self.pay_later(payment_entry)

    else                                                   # Process Pay-Now request
      self.pay_now(payment_entry)
    end
  end

  def pay_now(payment_entry)
    payment_entry.initiate_payment(
      total_cost,                                          # Payment.bill_amount
      self.get_adjustment_amount,                          # Payment.adjustment_amount
      'initiated',                                         # Payment.status
      self.user.get_payment_method_id(self.payment_type)   # Payment.payment_method_id
    )
    end

  def pay_later(payment_entry)
    payment_entry.initiate_payment(
      total_cost,                                          # Payment.bill_amount
      self.get_adjustment_amount(),                        # Payment.adjustment_amount
      'initiated',                                         # Payment.status
      nil                                                  # Payment.payment_method_id
    )
    payment_entry.complete_payment(Payment::SUCCESS)

    self.adjustments.create(
      user_id: user_id,
      adjustment_type: Adjustment::LATERPAYMENT,
      amount: total_cost
    )
  end

  validates :liters_taken, :unit_cost, :payment_status, :payment_type, presence: true
  validates :payment_status, inclusion: payment_statuses.keys
end
