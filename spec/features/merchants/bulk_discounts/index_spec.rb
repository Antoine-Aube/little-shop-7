require 'rails_helper'

RSpec.describe 'Bulk Discount Index Page' do
  describe "#index"
    it "displays all bulk discounts for a merchant with the discount attributes" do
      @merchant = Merchant.create!(name: 'Liberty Heights Fresh')
      @discount_1 = BulkDiscount.create!(name: "20% off!", percentage: 0.20, item_threshold: 10, merchant_id: @merchant.id)
      @discount_2 = BulkDiscount.create!(name: "30% off!", percentage: 0.30, item_threshold: 15, merchant_id: @merchant.id)

      visit merchant_bulk_discounts_path(@merchant)
      within("#discount-#{@discount_1.id}") do
        expect(page).to have_content(@discount_1.name)
        expect(page).to have_content("20%")
        expect(page).to have_content(@discount_1.item_threshold)
      end 
      within("#discount-#{@discount_2.id}") do
        expect(page).to have_content(@discount_2.name)
        expect(page).to have_content("30%")
        expect(page).to have_content(@discount_2.item_threshold)  
      end 
    end


    describe "#delete" do
      it "has a button to delete a discount next to each discount" do
        @merchant = Merchant.create!(name: 'Liberty Heights Fresh')
        @discount_1 = BulkDiscount.create!(name: "20% off!", percentage: 0.20, item_threshold: 10, merchant_id: @merchant.id)
        @discount_2 = BulkDiscount.create!(name: "30% off!", percentage: 0.30, item_threshold: 15, merchant_id: @merchant.id)

        visit merchant_bulk_discounts_path(@merchant)
        within("#discount-#{@discount_1.id}") do
          expect(page).to have_button("Delete Discount")
        end 
        within("#discount-#{@discount_2.id}") do
          expect(page).to have_button("Delete Discount")
        end 
      end

      it "deletes the discount when the delete button is clicked" do
        @merchant = Merchant.create!(name: 'Liberty Heights Fresh')
        @discount_1 = BulkDiscount.create!(name: "20% off!", percentage: 0.20, item_threshold: 10, merchant_id: @merchant.id)
        @discount_2 = BulkDiscount.create!(name: "30% off!", percentage: 0.30, item_threshold: 15, merchant_id: @merchant.id)

        visit merchant_bulk_discounts_path(@merchant)

        within("#discount-#{@discount_1.id}") do
          click_button("Delete Discount")
        end 

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
        expect(page).to_not have_content(@discount_1.name)
        expect(page).to_not have_content("20%")
        expect(page).to_not have_content(@discount_1.item_threshold)

        expect(page).to have_content(@discount_2.name)
        expect(page).to have_content("30%")
        expect(page).to have_content(@discount_2.item_threshold)
      end
    end
end