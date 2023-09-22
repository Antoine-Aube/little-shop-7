# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Merchant.destroy_all
Item.destroy_all
Customer.destroy_all
Invoice.destroy_all
Transaction.destroy_all
InvoiceItem.destroy_all
Rake::Task["load_csv:all"].invoke

@discount_1 = BulkDiscount.create!(name: "20% off!", percentage: 0.20, item_threshold: 10, merchant_id: 10)
@discount_2 = BulkDiscount.create!(name: "30% off!", percentage: 0.30, item_threshold: 15, merchant_id: 10)
@discount_3 = BulkDiscount.create!(name: "40% off!", percentage: 0.40, item_threshold: 20, merchant_id: 10)