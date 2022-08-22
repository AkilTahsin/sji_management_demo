class Payment < ApplicationRecord
  belongs_to :bill
  belongs_to :payment_method
  # before_save :complete_payment

  INITIATED = 0
  SUCCESS = 1
  FAILED = 2

  enum status: {
    Initiated: INITIATED,
    Successful: SUCCESS,
    Failed: FAILED
  }

  validates :bill_amount, :adjustment_amount, :total_amount, :status, presence: true
  # validates :status, inclusion: status.keys
  # validates :status, numericality: {in: 0..2}

  def complete_payment
    update(
      status: Payment::SUCCESS,
      total_amount: bill_amount + adjustment_amount
    )
    bill.creator.update(
      adjustment_balance: bill.creator.adjustment_balance - adjustment_amount
    )
    bill.update(payment_status: Bill::PAID)
  end

  def create_payment(bill)
    adjustment_amount = if creator.adjustment_balance >= total_cost
                          bill.total_cost
                        else
                          bill.creator.adjustment_balance
                        end

    # puts adjustment_amount
    bill.payments.create(
      adjustment_amount: adjustment_amount,
      total_amount: bill.bill_amount - adjustment_amount,
      status: Payment::INITIATED
    )
  end

end