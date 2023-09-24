require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should have_many(:invoice_items) }
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:merchants) }
  end

  describe 'validations' do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :status }
  end

  context 'standard set up' do
    before :each do
      @customer_1 = Customer.create(first_name: "Joey", last_name:"One")

      @merchant_1 = Merchant.create(name: "merchant1")
      @item_1 = Item.create(name: "item1", description: "1", unit_price: 2145, merchant: @merchant_1)
      @item_2 = Item.create(name: "item2", description: "1", unit_price: 2145, merchant: @merchant_1)

      @invoice_1 = Invoice.create(customer: @customer_1, status: 0)
      @invoice_2 = Invoice.create(customer: @customer_1, status: 1)
      @invoice_3 = Invoice.create(customer: @customer_1, status: 2)

      @invoice_item_1 = InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 23, unit_price: 34343, status: 0)
      @invoice_item_2 = InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 23, unit_price: 34343, status: 1)
      @invoice_item_3 = InvoiceItem.create(item: @item_1, invoice: @invoice_2, quantity: 23, unit_price: 34343, status: 2)
      @invoice_item_4 = InvoiceItem.create(item: @item_1, invoice: @invoice_2, quantity: 23, unit_price: 34343, status: 0)
      @invoice_item_5 = InvoiceItem.create(item: @item_1, invoice: @invoice_3, quantity: 23, unit_price: 34343, status: 2)
      @invoice_item_6 = InvoiceItem.create(item: @item_2, invoice: @invoice_3, quantity: 23, unit_price: 34343, status: 2)
    end

    describe 'class methods' do
      describe '#incomplete_invoices' do
        it "shows a list of invoices that have not yet shipped" do
          expect(Invoice.incomplete_invoices).to eq([@invoice_1, @invoice_2])
        end
      end
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

  describe "instance methods" do
    describe "#revenue_for_specific_invoice" do
      it "returns the total revenue for a specific invoice" do
        merchant_1 = Merchant.create(name: "merchant1")
        item_1 = Item.create(name: "item1", description: "1", unit_price: 10, merchant: merchant_1)
        item_2 = Item.create(name: "item2", description: "1", unit_price: 10, merchant: merchant_1)
        invoice_1 = Invoice.create(customer: Customer.create(first_name: "Joey", last_name:"One"), status: 0)
        invoice_item_1 = InvoiceItem.create(item: item_1,invoice: invoice_1, quantity: 10, unit_price: 10, status: 0)
        invoice_item_2 = InvoiceItem.create(item: item_2, invoice: invoice_1, quantity: 10, unit_price: 10, status: 0)

        expect(invoice_1.revenue_for_specific_invoice(merchant_1)).to eq(200)
      end 
    end

    describe "#discount_for_specific_invoice" do
      it "returns the total discounts for a specific invoice, adjusts according to best discount available" do
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

        expect(invoice_1.discount_for_specific_invoice(merchant_1)).to eq(40)

        bulk_discount_3 = BulkDiscount.create(name: "30% off 30 items", percentage: 0.30, item_threshold: 10, merchant: merchant_1)

        expect(invoice_1.discount_for_specific_invoice(merchant_1)).to eq(60)
      end 
    end

    describe "#discounted_revenue_for_specific_invoice" do
      it "subtracts the discount total from the invoice total" do 
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

        expect(invoice_1.discounted_revenue_for_specific_invoice(merchant_1)).to eq(210)

        bulk_discount_3 = BulkDiscount.create(name: "30% off 30 items", percentage: 0.30, item_threshold: 10, merchant: merchant_1)

        expect(invoice_1.discounted_revenue_for_specific_invoice(merchant_1)).to eq(190)
      end
    end
  end
end