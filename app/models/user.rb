class User < ApplicationRecord
  has_many :bills, class_name: 'Bill', foreign_key: :user_id
  has_many :payment_methods, dependent: :destroy
  has_many :adjustments, dependent: :destroy

  validates :name, :adjustment_balance, presence: true

  def default_payment_method
    self.payment_methods.find_by(is_default: :true)
  end

  def get_payment_method_id(type)
        self.payment_methods.find_by(payment_type: type).id
  end
end
