class Adjustment < ApplicationRecord
  belongs_to :bill
  belongs_to :user

  LATERPAYMENT = 0
  REFUND = 1
  EXTRACHARGE = 2

  before_create :set_user
  after_create :adjust_user_amount
  def set_user
    self.user_id = self.bill.creator_id
  end
  def adjust_user_amount
    self.user.update(adjustment_balance: self.user.adjustment_balance + self.amount)
  end

  enum adjustment_type: {
    LaterPayment: LATERPAYMENT,
    Refund: REFUND,
    ExtraCharge: EXTRACHARGE
  }

  scope :refunds, -> { where(adjustment_type: REFUND) }
  scope :pay_later, -> { where(adjustment_type: PAYLATER) }

end