class Payment < ApplicationRecord
  belongs_to :bill
  belongs_to :payment_method
  before_save :complete_payment

  INITIATED = 0
  SUCCESS = 1
  FAILED = 2

  enum status: {
    Initiated: INITIATED,
    Successful: SUCCESS,
    Failed: FAILED
  }

  # validates :bill_amount, :adjustment_amount, :total_amount, :status, presence: true
  # validates :status, inclusion: status.keys
  # validates :status, numericality: {in: 0..2}

  def complete_payment
    self.update(
      status: Payment::SUCCESS,
      total_amount: self.bill_amount + self.adjustment_amount
    )
    self.bill.creator.update(
      adjustment_balance: self.bill.creator.adjustment_balance - self.adjustment_amount
    )
    self.bill.update(payment_status: Bill::PAID)
  end
  
  after_save do
    puts "Payment entry created."
  end

end