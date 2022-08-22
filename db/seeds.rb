# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.create(name: "David", adjustment_balance: 10)
User.create(name: "Kalam", adjustment_balance: 50)
User.create(name: "Aarong", adjustment_balance: -10)

PaymentMethod.create(is_default: :true, payment_type: 'bank', bank_account: 12345678, bank_details: "abcBanking", user_id: 1)
PaymentMethod.create(is_default: :true, payment_type: 'card', card_number: 82729573, card_details: "WordleBank", user_id: 1)
PaymentMethod.create(is_default: :true, payment_type: 'bank', bank_account: 92059385, bank_details: "xyzBanking", user_id: 2)
PaymentMethod.create(is_default: :true, payment_type: 'card', bank_account: 12324578, bank_details: "jwrowBanking", user_id: 3)

Bill.create(title: "1imei2dod2", liters_taken: 5, unit_cost: 10, payment_status: 'Unpaid', creator_id: 1)
Bill.create(title: "ni2edhbn3fu", liters_taken: 10, unit_cost: 13, payment_status: 'PayLater', creator_id: 1)
Bill.create(title: "", liters_taken: 2, unit_cost: 4, payment_status: 'Unpaid', creator_id: 2)
Bill.create(title: "kl3fmi3nfi3", liters_taken: 9, unit_cost: 8, payment_status: 'PayLater', creator_id: 2)
Bill.create(title: "k2oej92f", liters_taken: 6, unit_cost: 10, payment_status: 'Unpaid', creator_id: 1)
Bill.create(title: "nd29dj29dj2", liters_taken: 8, unit_cost: 21, payment_status: 'PayLater', creator_id: 1)
Bill.create(title: "jiwew", liters_taken: 2, unit_cost: 4, payment_status: 'Unpaid', creator_id: 2)
Bill.create(title: "asu2hd0j3", liters_taken: 9, unit_cost: 8, payment_status: 'PayLater', creator_id: 2)

