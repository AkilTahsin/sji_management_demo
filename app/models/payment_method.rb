class PaymentMethod < ApplicationRecord
  belongs_to :user  
  has_many :payments, dependent: :destroy
  before_save :check_payment_type
  
  enum payment_type: {
    card: 1,
    bank: 2
  }

  validates :is_default, :payment_type, presence: true

  validates :payment_type, inclusion: payment_types.keys

  def check_payment_type
    if self.card?
      errors.add(:card, "fields cannot be empty.")
      raise ActiveRecord::RecordInvalid.new(self)

    elsif self.bank?
      errors.add(:card, "fields cannot be empty.")
      raise ActiveRecord::RecordInvalid.new(self)
    else
      errors.add(:payment_type, "invalid.")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
  
end
