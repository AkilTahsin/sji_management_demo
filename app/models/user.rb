class User < ApplicationRecord
  has_many :bills, class_name: 'Bill', foreign_key: :creator_id
  has_many :payment_methods, dependent: :destroy
  has_many :adjustments, dependent: :destroy

  validates :name, :adjustment_balance, presence: true
end
