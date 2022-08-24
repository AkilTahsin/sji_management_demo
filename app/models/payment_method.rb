class PaymentMethod < ApplicationRecord
  belongs_to :user  
  has_many :payments, dependent: :destroy
  before_save :check_payment_type
  
  enum payment_type: {
    card: 1,
    bank: 2
  }

  validates :payment_type, inclusion: payment_types.keys

  def check_payment_type
    if self.card?
      errors.add(:card, "fields cannot be empty.")
      self.errors[:base] << "This person is invalid because of incomplete card information"

    elsif self.bank?
      errors.add(:bank, "fields cannot be empty.")
      self.errors[:base] << "This person is invalid because of incomplete bank information"
    else
      errors.add(:payment_type, "invalid.")
      self.errors[:base] << "This person is invalid because of unknown payment information"
    end
  end
end
