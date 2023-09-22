require 'rails_helper'

RSpec.describe 'Edit Bulk Discount' do
  describe "#edit" do
    it "has a form to edit a bulk discount that has current attributes populated" do
      @merchant = Merchant.create!(name: 'Liberty Heights Fresh')
      @discount_1 = BulkDiscount.create!(name: "20% off!", percentage: 0.20, item_threshold: 10, merchant_id: @merchant.id)
      @discount_2 = BulkDiscount.create!(name: "30% off!", percentage: 0.30, item_threshold: 15, merchant_id: @merchant.id)
      visit edit_merchant_bulk_discount_path(@merchant, @discount_1)

      expect(page).to have_content("Edit #{@discount_1.name}")
      expect(page).to have_field(:name, with: @discount_1.name)
      expect(page).to have_field(:percentage, with: @discount_1.percentage)
      expect(page).to have_field(:item_threshold, with: @discount_1.item_threshold)
    end

    it "updates the bulk discount when all fields are filled in correctly" do
      @merchant = Merchant.create!(name: 'Liberty Heights Fresh')
      @discount_1 = BulkDiscount.create!(name: "20% off!", percentage: 0.20, item_threshold: 10, merchant_id: @merchant.id)
      @discount_2 = BulkDiscount.create!(name: "30% off!", percentage: 0.30, item_threshold: 15, merchant_id: @merchant.id)
      visit edit_merchant_bulk_discount_path(@merchant, @discount_1)

      fill_in(:name, with: "10% off 10 items")
      fill_in(:percentage, with: 0.10)
      fill_in(:item_threshold, with: 5)
      click_button("Update Discount")

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_1))
      expect(page).to have_content("10% off 10 items")
      expect(page).to have_content("10")
      expect(page).to have_content("10%")
    end

    it "displays an error message when a field is missing" do
      @merchant = Merchant.create!(name: 'Liberty Heights Fresh')
      @discount_1 = BulkDiscount.create!(name: "20% off!", percentage: 0.20, item_threshold: 10, merchant_id: @merchant.id)
      @discount_2 = BulkDiscount.create!(name: "30% off!", percentage: 0.30, item_threshold: 15, merchant_id: @merchant.id)
      visit edit_merchant_bulk_discount_path(@merchant, @discount_1)

      fill_in(:name, with: "")
      fill_in(:percentage, with: 0.10)
      fill_in(:item_threshold, with: 5)
      click_button("Update Discount")

      expect(page).to have_content("Discount not updated: Required information missing.")
    end
  end
end