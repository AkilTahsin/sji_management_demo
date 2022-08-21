class CreateAdjustments < ActiveRecord::Migration[7.0]
  def change
    create_table :adjustments do |t|
      t.references :bill, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :amount
      t.integer :adjustment_type

      t.timestamps
    end
  end
end
