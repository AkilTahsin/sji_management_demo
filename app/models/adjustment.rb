class Adjustment < ApplicationRecord
  belongs_to :bill
  belongs_to :user

  # Integers [0,1,2] represents pending adjustment type
  enum adjustment_type{
    "Pay Later" => 0,
    "Refund" => 1,
    "Extra Charge" => 2
  }
  
  validates :amount, :adjustment_type, presence: true
  validates :adjustment_type, inclusion: adjustment_type.keys
end