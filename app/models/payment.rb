class Payment < ApplicationRecord
  belongs_to :bill
  belongs_to :payment_method

  after_initialize do
  
    if self.id.blank?
      bill_amount = Bill.total_cost
      set_adjustment_amount()
      self.adjustment_amount = self.bill_amount + self.adjustment_amount
    end

  end
  
  after_save do
    puts "Payment entry created."
  end

  # Integers [0,1,2] represents results of payment
  enum status: {
    Initiated: 0,
    Successful: 1,
    Failed: 2
  }


  def set_adjustment_amount
    if (self.bill_amount + User.adjustment_balance) >= 0
      self.adjustment_amount = User.adjustment_balance
    else
      self.adjustment_amount = -self.bill_amount
    end
  end

  def payment_completed
    self.status = 'paid'
    Bill.
  end
  

  validates :bill_amount, :adjustment_amount, :total_amount, :status, presence: true
  validates :status, inclusion: status.keys

  validates :status, numericality: {in: 0..2}

end
