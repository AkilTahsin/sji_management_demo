# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_21_120015) do
  create_table "adjustments", force: :cascade do |t|
    t.integer "bill_id", null: false
    t.integer "user_id", null: false
    t.integer "amount"
    t.integer "adjustment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_adjustments_on_bill_id"
    t.index ["user_id"], name: "index_adjustments_on_user_id"
  end

  create_table "bills", force: :cascade do |t|
    t.integer "user_id"
    t.text "title"
    t.integer "liters_taken"
    t.integer "unit_cost"
    t.integer "total_cost"
    t.integer "payment_status", default: 0
    t.string "payment_type", default: "paylater"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "is_default", default: false
    t.integer "payment_type"
    t.integer "card_number"
    t.text "card_details"
    t.integer "bank_account"
    t.text "bank_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payment_methods_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "bill_id", null: false
    t.integer "bill_amount"
    t.integer "adjustment_amount"
    t.integer "total_amount"
    t.string "status"
    t.integer "payment_method_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_payments_on_bill_id"
    t.index ["payment_method_id"], name: "index_payments_on_payment_method_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "name"
    t.integer "adjustment_balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "adjustments", "bills"
  add_foreign_key "adjustments", "users"
  add_foreign_key "payment_methods", "users"
  add_foreign_key "payments", "bills"
  add_foreign_key "payments", "payment_methods"
end
