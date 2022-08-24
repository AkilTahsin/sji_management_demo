class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.text :title
      t.integer :liters_taken
      t.integer :unit_cost
      t.integer :total_cost
      t.integer :payment_status, default: 0
      t.string :payment_type, default: 'paylater'

      t.timestamps
    end
  end
end
