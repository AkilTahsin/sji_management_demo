class User < ApplicationRecord
has_many :bills, dependent: :destroy
has_many :payment_methods, dependent: :destroy
has_many :adjustments, dependent: :destroy

validates :name, :adjustment_balance, presence: true

end
