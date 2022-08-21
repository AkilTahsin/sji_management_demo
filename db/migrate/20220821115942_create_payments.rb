class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :bill, null: false, foreign_key: true
      t.integer :bill_amount
      t.integer :adjustment_amount
      t.integer :total_amount
      t.integer :status
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
