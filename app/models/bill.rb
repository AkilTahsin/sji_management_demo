class Bill < ApplicationRecord
  belongs_to :user
  has_many :payments, dependent: :destroy
  has_many :adjustments, dependent: :destroy

  after_initialize do
    add_total_cost()
  end
  after_save do
    pay_when()
  end

  enum payment_status: {
    pay_later: 0,
    unpaid: 1,
    paid: 2
  }
  
  validates :liters_taken, :unit_cost, numericality: {greater_than_or_equal_to: 0.01}

  def add_total_cost
    self.total_cost = self.liters_taken * self.unit_cost
  end

  def pay_when()
    if !self.pay_later?
      # puts self.payment_status
      # Payment.new(bill_id: self.id, bill_amount: self.total_cost, adjustment_amount: Adjustment[:user_id].amount, status: 'Initiated')

    end
  end

  validates :liters_taken, :unit_cost, :payment_status, presence: true
  validates :payment_status, inclusion: payment_statuses.keys
end