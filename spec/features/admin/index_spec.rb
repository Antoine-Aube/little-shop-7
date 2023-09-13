require "rails_helper"

RSpec.feature "the admin index page" do
  describe 'when visiting /admin' do
    it 'US19 shows a header indicating that we are on the admin dashboard' do

      visit admin_path

      expect(page).to have_content("Admin Dashboard")
    end
  end

  describe 'when visiting /admin' do
    it 'US20 shows a link to /admin/merchants and /admin/invoices' do

      visit admin_path

      expect(page).to have_content("Admin Dashboard")
      within (".links") do
        expect(page).to have_link("Merchants")
        expect(page).to have_link("Invoices")
        click_link("Merchants")
        expect(page).to have_current_path(admin_merchants_path)
        visit admin_path
        click_link("Invoices")
        expect(page).to have_current_path(admin_invoices_path)
      end
    end
  end

  describe 'when visiting /admin' do
    describe 'US21 shows the top 5 customers who have conducted the largest number of successful transactions' do
      it "shows next to each customer name, the number of successful transactions they have executed" do
        customer_1 = Customer.create(first_name: "Joey", last_name:"One")
        customer_2 = Customer.create(first_name: "John", last_name:"Two")
        customer_3 = Customer.create(first_name: "Joselyn", last_name:"Three")
        customer_4 = Customer.create(first_name: "Jerry", last_name:"Four")
        customer_5 = Customer.create(first_name: "Jackson", last_name:"Five")
        customer_6 = Customer.create(first_name: "Jojo", last_name:"Six")
    
        invoice_1 = Invoice.create(customer: customer_1, status: 1)
        invoice_2 = Invoice.create(customer: customer_1, status: 1)
        invoice_3 = Invoice.create(customer: customer_2, status: 1)
        invoice_4 = Invoice.create(customer: customer_2, status: 1)
        invoice_5 = Invoice.create(customer: customer_2, status: 1)
        invoice_6 = Invoice.create(customer: customer_3, status: 1)
        invoice_7 = Invoice.create(customer: customer_4, status: 1)
        invoice_8 = Invoice.create(customer: customer_4, status: 1)
        invoice_9 = Invoice.create(customer: customer_4, status: 1)
        invoice_10 = Invoice.create(customer: customer_4, status: 1)
        invoice_11 = Invoice.create(customer: customer_4, status: 1)
        invoice_12 = Invoice.create(customer: customer_5, status: 1)
        invoice_13 = Invoice.create(customer: customer_5, status: 1)
        invoice_14 = Invoice.create(customer: customer_5, status: 1)
        invoice_15 = Invoice.create(customer: customer_5, status: 1)
        invoice_16 = Invoice.create(customer: customer_5, status: 1)
        invoice_17 = Invoice.create(customer: customer_5, status: 1)
        invoice_18 = Invoice.create(customer: customer_6, status: 1)
        invoice_19 = Invoice.create(customer: customer_6, status: 1)
        invoice_20 = Invoice.create(customer: customer_6, status: 1)
        invoice_21 = Invoice.create(customer: customer_6, status: 1)
    
        transaction_1 = Transaction.create(invoice: invoice_1, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_2 = Transaction.create(invoice: invoice_2, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_3 = Transaction.create(invoice: invoice_3, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_4 = Transaction.create(invoice: invoice_4, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_5 = Transaction.create(invoice: invoice_5, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_6 = Transaction.create(invoice: invoice_6, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_7 = Transaction.create(invoice: invoice_7, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_8 = Transaction.create(invoice: invoice_8, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_9 = Transaction.create(invoice: invoice_9, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_10 = Transaction.create(invoice: invoice_10, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_11 = Transaction.create(invoice: invoice_11, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_12 = Transaction.create(invoice: invoice_12, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_13 = Transaction.create(invoice: invoice_13, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_14 = Transaction.create(invoice: invoice_14, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_15 = Transaction.create(invoice: invoice_15, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_16 = Transaction.create(invoice: invoice_16, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_17 = Transaction.create(invoice: invoice_17, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_18 = Transaction.create(invoice: invoice_18, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_19 = Transaction.create(invoice: invoice_18, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_20 = Transaction.create(invoice: invoice_18, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        transaction_21 = Transaction.create(invoice: invoice_18, credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: 1 )
        visit admin_path

        within (".top_customers") do
          expect(page).to have_content("Top Customers")
          expect(page).to_not have_content(customer_3.first_name)

          expect("Jackson Five - 6 Purchases").to appear_before("Jerry Four - 5 Purchases")
          expect("Jerry Four - 5 Purchases").to appear_before("Jojo Six - 4 Purchases")
          expect("Jojo Six - 4 Purchases").to appear_before("John Two - 3 Purchases")
          expect("John Two - 3 Purchases").to appear_before("Joey One - 2 Purchases")
        end
      end
    end
  end
  describe 'when visiting /admin' do
    describe 'US22 shows a section for incomplete invoices that shows a list of all invoice:  ids that have not yet been shipped' do
      it "each invoice:  id links to that invoice: 's admin show page" do
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
        
        visit admin_path
        within (".incomplete_invoices") do
          expect(page).to have_content("Incomplete Invoices")
          expect(page).to_not have_content(invoice_3.id)
          expect(page).to have_content("Invoice Number #{invoice_1.id}")
          expect(page).to have_content("Invoice Number #{invoice_2.id}")
          expect(page).to have_link("#{invoice_2.id}")
          click_link("#{invoice_2.id}")
          expect(page).to have_current_path(admin_invoice_path(invoice_2.id))
        end
      end
    end
  end

  describe 'when visiting /admin' do
    describe 'US23 shows a section for incomplete invoices ordered by oldest invoice"' do
      it "is formatted to 'Monday, July 18, 2019'" do
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
        
        visit admin_path
        within (".incomplete_invoices") do
          expect(page).to have_content("Incomplete Invoices")
          expect(page).to_not have_content(invoice_3.id)
          expect(page).to_not have_content(invoice_3.id)
          expect(page).to have_content("Invoice Number #{invoice_1.id} - #{invoice_1.created_at.strftime("%A, %B %d, %Y")}")
          expect(page).to have_content("Invoice Number #{invoice_2.id} - #{invoice_2.created_at.strftime("%A, %B %d, %Y")}")

        end
      end
    end
  end
end
    