class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      # t.belongs_to :user, null: false, foreign_key: true
      t.integer :creator_id
      t.text :title
      t.integer :liters_taken
      t.integer :unit_cost
      t.integer :total_cost
      t.integer :payment_status

      t.timestamps
    end
  end
end
