class Payment < ApplicationRecord
  belongs_to :bill
  belongs_to :payment_method

  # Integers [0,1,2] represents results of payment
  enum status: {
    "Initiated" => 0,
    "Successful" => 1,
    "Failed" => 2
  }

  def adjustment_amount
    adjustment_amount = Bill.Adjustment.amount
  end

  def total_amount
    bill_amount = Bill.total_cost
    total_amount = bill_amount + adjustment_amount
  end

  validates :bill_amount, :adjustment_amount, :total_amount, :status, presence: true
  validates :status, inclusion: status.keys

  validates :status, numericality: {in: 0..2}

end
