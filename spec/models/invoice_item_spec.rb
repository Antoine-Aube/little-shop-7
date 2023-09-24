require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
  end

  describe '#unit_price_to_decimal' do
    it "formats the unit price of an invoice item" do
      customer_1 = Customer.create(first_name: "Joey", last_name:"One")
      merchant_1 = Merchant.create(name: "merchant1")
      item_1 = Item.create(name: "item1", description: "1", unit_price: 2145, merchant: merchant_1)
      item_2 = Item.create(name: "item2", description: "1", unit_price: 2145, merchant: merchant_1)

      invoice_1 = Invoice.create(customer: customer_1, status: 0)

      invoice_item_1 = InvoiceItem.create(item: item_1, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 0)
      invoice_item_2 = InvoiceItem.create(item: item_2, invoice: invoice_1, quantity: 23, unit_price: 34343, status: 1)

      expect(invoice_item_1.unit_price_to_decimal).to eq(343.43)
    end
  end

  describe '#applied_discount' do
    it "returns the highest discount that can be applied to the invoice item" do 
      merchant_1 = Merchant.create(name: "merchant1")
        item_1 = Item.create(name: "item1", description: "1", unit_price: 10, merchant: merchant_1)
        item_2 = Item.create(name: "item2", description: "1", unit_price: 10, merchant: merchant_1)
        item_3 = Item.create(name: "item3", description: "1", unit_price: 10, merchant: merchant_1)
        invoice_1 = Invoice.create(customer: Customer.create(first_name: "Joey", last_name:"One"), status: 0)
        invoice_item_1 = InvoiceItem.create(item: item_1,invoice: invoice_1, quantity: 10, unit_price: 10, status: 0)
        invoice_item_2 = InvoiceItem.create(item: item_2, invoice: invoice_1, quantity: 10, unit_price: 10, status: 0)
        invoice_item_3 = InvoiceItem.create(item: item_3, invoice: invoice_1, quantity: 5, unit_price: 10, status: 0)
        bulk_discount_1 = BulkDiscount.create(name: "10% off 10 items", percentage: 0.10, item_threshold: 10, merchant: merchant_1)
        bulk_discount_2 = BulkDiscount.create(name: "20% off 20 items", percentage: 0.20, item_threshold: 10, merchant: merchant_1)

        expect(invoice_item_1.applied_discount).to eq(bulk_discount_2)
        expect(invoice_item_2.applied_discount).to eq(bulk_discount_2)
    end
  end
end