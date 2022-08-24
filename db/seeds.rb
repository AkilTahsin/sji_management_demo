# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.create(name: "David", adjustment_balance: 10)
User.create(name: "Kalam", adjustment_balance: 50)
User.create(name: "Aarong", adjustment_balance: -10)

PaymentMethod.create(is_default: 1, payment_type: 'bank', bank_account: 12345678, bank_details: "abcBanking", user_id: 1)
PaymentMethod.create(is_default: 1, payment_type: 'card', card_number: 26684534, card_details: "wowbanking", user_id: 2)
PaymentMethod.create(is_default: 1, payment_type: 'card', card_number: 12324578, card_details: "jwrowBanking", user_id: 3)
PaymentMethod.create(is_default: 0, payment_type: 'card', card_number: 35645678, card_details: "nycBanking", user_id: 1)
PaymentMethod.create(is_default: 0, payment_type: 'bank', bank_account: 79482434, bank_details: "nicebanking", user_id: 2)
PaymentMethod.create(is_default: 0, payment_type: 'bank', card_number: 35324578, card_details: "bankaustr", user_id: 3)

Bill.create(title: "1imei2dod2", liters_taken: 5, unit_cost: 10, payment_type: 'bank', user_id: 1)
Bill.create(title: "ni2edhbn3fu", liters_taken: 10, unit_cost: 13, user_id: 1)
Bill.create(title: "lorem ipsum", liters_taken: 20, unit_cost: 4, payment_type: 'card', user_id: 3)
Bill.create(title: "kl3fmi3nfi3", liters_taken: 9, unit_cost: 8, user_id: 2)
Bill.create(title: "k2oej92f", liters_taken: 6, unit_cost: 10, payment_type: 'bank', user_id: 3)
Bill.create(title: "nd29dj29dj2", liters_taken: 8, unit_cost: 21, user_id: 1)
Bill.create(title: "jiwew", liters_taken: 2, unit_cost: 4, payment_type: 'card', user_id: 2)
Bill.create(title: "asu2hd0j3", liters_taken: 9, unit_cost: 8, user_id: 3)

