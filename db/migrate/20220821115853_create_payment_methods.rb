class CreatePaymentMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_methods do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :is_default, default: false
      t.integer :payment_type
      t.integer :card_number, null: true
      t.text :card_details, null: true
      t.integer :bank_account, null: true
      t.text :bank_details, null: true

      t.timestamps
    end
  end
end
