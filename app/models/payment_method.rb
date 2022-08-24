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
    if self.payment_type.eql? 'card' and (!self.card_details? and !self.card_number?)
      errors.add(:payment_type, " fields cannot be empty.")
      raise ActiveRecord::RecordInvalid.new(self)
    
    elsif self.payment_type.eql? 'bank' and (!self.bank_details? and !self.bank_account?)
      errors.add(:payment_type, " fields cannot be empty.")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
