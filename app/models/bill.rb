class Bill < ApplicationRecord
  belongs_to :user

  # Integers [0,1,2] represents different states of payment via enum
  enum payment_status: {
    "Pay Later" => 0,
    "Unpaid" => 1,
    "Paid" => 2
  }

  def total_cost
    total_cost = liters_taken * unit_cost
  end
  
  validates :liters_taken, :unit_cost, :total_cost, :payment_status, presence: true
  validates :payment_status, inclusion: payment_status.keys

validates 
end