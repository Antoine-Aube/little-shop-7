require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :status }
  end

  describe '#incomplete_invoices' do
    it "shows a list of invoices that have not yet shipped and orders by oldest invoice by created_at" do
      customer_1 = Customer.create(first_name: "Joey", last_name:"One")

      merchant_1 = Merchant.create(name: "merchant1")
      item_1 = Item.create(name: "item1", description: "1", unit_price: 2145, merchant: merchant_1)
      item_2 = Item.create(name: "item2", description: "1", unit_price: 2145, merchant: merchant_1)
  
      invoice_1 = Invoice.create(customer: customer_1, status: 0)
      invoice_2 = Invoice.create(customer: customer_1, status: 1)
      invoice_3 = Invoice.create(customer: customer_1, status: 2)
  
      invoice_item_1 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 0)
      invoice_item_2 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 1)
      invoice_item_3 = InvoiceItem.create(item: item_1, invoice: invoice_2, quantity: 23, unit_price: 34343, status: 2)
      invoice_item_4 = InvoiceItem.create(item: item_1, invoice: invoice_2, quantity: 23, unit_price: 34343, status: 0)
      invoice_item_5 = InvoiceItem.create(item: item_1, invoice: invoice_3, quantity: 23, unit_price: 34343, status: 2)
      invoice_item_6 = InvoiceItem.create(item: item_2, invoice: invoice_3, quantity: 23, unit_price: 34343, status: 2)
      
      expect(Invoice.incomplete_invoices).to eq([invoice_1,invoice_2])
    end
  end

  describe '#total_revenue' do
    it "shows a list of invoices that have not yet shipped and orders by oldest invoice by created_at" do
      customer_1 = Customer.create(first_name: "Joey", last_name:"One")
      merchant_1 = Merchant.create(name: "merchant1")
      item_1 = Item.create(name: "item1", description: "1", unit_price: 2145, merchant: merchant_1)
      item_2 = Item.create(name: "item2", description: "1", unit_price: 2145, merchant: merchant_1)
      invoice_1 = Invoice.create(customer: customer_1, status: 0)
  
      invoice_item_1 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 1, unit_price: 34343, status: 0)
      invoice_item_2 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 2, unit_price: 34343, status: 1)
      expect(invoice_1.total_revenue).to eq(1030.29)
    end
  end
end