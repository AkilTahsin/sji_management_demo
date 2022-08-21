class PaymentMethod < ApplicationRecord
  belongs_to :user
  
  
  enum payment_type: {
    "Cash" => 0,
    "Card" => 1,
    "Check" => 2
  }

  validates :is_default, :payment_type, presence: true
  validates :payment_type, inclusion: payment_type.keys
end
