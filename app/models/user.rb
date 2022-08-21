class User < ApplicationRecord
    has_many :bills
    has_many :payment_methods
    has_many :adjustments


validates :name, :adjustment_balance, presence: true

end
