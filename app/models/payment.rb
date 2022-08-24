class Payment < ApplicationRecord
  belongs_to :bill
  belongs_to :payment_method, optional: true

  INITIATED = 'initiated'
  PENDING = 'pending'
  SUCCESS = 'successful'
  FAILED = 'failed'

  enum status: {
    initiated: INITIATED,
    pending: PENDING,
    successful: SUCCESS,
    failed: FAILED
  }

  validates :bill_amount, :adjustment_amount, :total_amount, :status, presence: true
  
  def initiate_payment(bill_total_cost, bill_adjustment_amount, _status, bill_payment_method_by_id)
    self.bill_amount = bill_total_cost
    self.adjustment_amount = bill_adjustment_amount
    self.total_amount = self.bill_amount - self.adjustment_amount
    self.status = _status
    self.payment_method_id = bill_payment_method_by_id

    self.save!

    self.update(status: 'pending')
  end

  def complete_payment(_status)
    update(
      status: _status,
      total_amount: bill_amount + adjustment_amount
    )
    bill.user.update(
      adjustment_balance: bill.user.adjustment_balance - adjustment_amount
    )

    if _status.eql? 'successful'
      bill.update(payment_status: Bill::PAID)
    end
  end
end