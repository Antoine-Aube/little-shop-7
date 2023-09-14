require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of :name}
  end

  describe "instance methods" do 
    it "US3 #top_five_customers" do 

    merchant_1 = Merchant.create(name: "Merchant 1")

    item_1 = Item.create(name: "Item 1", description: "Item 1 description", unit_price: 100, merchant_id: merchant_1.id, status: 1)

    customer_1 = Customer.create(first_name: "Erica", last_name:"One")
    customer_2 = Customer.create(first_name: "Noelle", last_name:"Two")
    customer_3 = Customer.create(first_name: "Cory", last_name:"Three")
    customer_4 = Customer.create(first_name: "Terry", last_name:"Four")
    customer_5 = Customer.create(first_name: "Dani", last_name:"Five")
    customer_6 = Customer.create(first_name: "Juliet", last_name:"Six")

    invoice_1 = Invoice.create(customer_id: customer_1.id, status: 1)
    invoice_2 = Invoice.create(customer_id: customer_2.id, status: 1)
    invoice_3 = Invoice.create(customer_id: customer_3.id, status: 1)
    invoice_4 = Invoice.create(customer_id: customer_4.id, status: 1)
    invoice_5 = Invoice.create(customer_id: customer_5.id, status: 1)
    invoice_6 = Invoice.create(customer_id: customer_6.id, status: 1)

    invoice_items_1 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 100, status: 1)
    invoice_items_2 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 200, status: 1)
    invoice_items_3 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 300, status: 1)
    invoice_items_4 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_4.id, quantity: 3, unit_price: 300, status: 1)
    invoice_items_5 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 300, status: 1)
    invoice_items_6 = InvoiceItem.create(item_id: item_1.id, invoice_id: invoice_6.id, quantity: 3, unit_price: 300, status: 1)

    transaction_1 = Transaction.create(invoice_id: invoice_1.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_2 = Transaction.create(invoice_id: invoice_2.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_3 = Transaction.create(invoice_id: invoice_2.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_4 = Transaction.create(invoice_id: invoice_3.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_5 = Transaction.create(invoice_id: invoice_3.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_6 = Transaction.create(invoice_id: invoice_3.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_7 = Transaction.create(invoice_id: invoice_4.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_8 = Transaction.create(invoice_id: invoice_4.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_9 = Transaction.create(invoice_id: invoice_4.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_10 = Transaction.create(invoice_id: invoice_4.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_11 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_12 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_13 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_14 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_15 = Transaction.create(invoice_id: invoice_5.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_16 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_17 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_18 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_19 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_20 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    transaction_21 = Transaction.create(invoice_id: invoice_6.id, credit_card_number: 123456789, credit_card_expiration_date: 1234, result: 1)
    # require 'pry';binding.pry
    expect(merchant_1.top_five_customers).to eq([customer_6, customer_5, customer_4, customer_3, customer_2])
    expect(merchant_1.top_five_customers[0]).to eq(customer_6)
    expect(merchant_1.top_five_customers[0].transaction_count).to eq(6)
    expect(merchant_1.top_five_customers[1]).to eq(customer_5)
    expect(merchant_1.top_five_customers[1].transaction_count).to eq(5)
    expect(merchant_1.top_five_customers[2]).to eq(customer_4)
    expect(merchant_1.top_five_customers[2].transaction_count).to eq(4)
    expect(merchant_1.top_five_customers[3]).to eq(customer_3)
    expect(merchant_1.top_five_customers[3].transaction_count).to eq(3)
    expect(merchant_1.top_five_customers[4]).to eq(customer_2)
    expect(merchant_1.top_five_customers[4].transaction_count).to eq(2)
    end
  end
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Queen Soopers", enabled: true)
    @merchant_2 = Merchant.create!(name: "Quick-E-Mart", enabled: true)
    @merchant_3 = Merchant.create!(name: "Veggi World", enabled: true)
    @merchant_4 = Merchant.create!(name: "Spatula City", enabled: true)
    @merchant_5 = Merchant.create!(name: "Just Powder", enabled: false)
    @merchant_6 = Merchant.create!(name: "Icee Freeze", enabled: false)
    @merchant_7 = Merchant.create!(name: "Water World", enabled: false)
  end

  describe "Class methods" do 
    it "returns all enabled merchants" do
      expect(Merchant.enabled).to eq([@merchant_1, @merchant_2, @merchant_3, @merchant_4])
    end

    it "returns all disabled merchants" do
      expect(Merchant.disabled).to eq([@merchant_5, @merchant_6, @merchant_7])
    end
  end
end