class Bill < ApplicationRecord
  belongs_to :user
  has_many :payments
  has_many :adjustments

  enum payment_status: {
    "Pay Later" => 0,
    "Unpaid" => 1,
    "Paid" => 2
  }

  validates :liters_taken, :unit_cost, numericality: {greater_than_or_equal_to: 0.01}

  def total_cost
    total_cost = liters_taken * unit_cost
  end
  
  validates :liters_taken, :unit_cost, :total_cost, :payment_status, presence: true
  validates :payment_status, inclusion: payment_status.keys

validates 
end