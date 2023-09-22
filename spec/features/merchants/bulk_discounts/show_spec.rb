require 'rails_helper'

RSpec.describe "Bulk Discount Show Page" do
  describe "#show" do
    it "displays the bulk discount's attributes" do
      @merchant = Merchant.create!(name: 'Liberty Heights Fresh')
      @discount_1 = BulkDiscount.create!(name: "20% off!", percentage: 0.20, item_threshold: 10, merchant_id: @merchant.id)
      @discount_2 = BulkDiscount.create!(name: "30% off!", percentage: 0.30, item_threshold: 15, merchant_id: @merchant.id)
      
      visit merchant_bulk_discount_path(@merchant, @discount_1)
      expect(page).to have_content(@discount_1.name)
      expect(page).to have_content("20%")
      expect(page).to have_content(@discount_1.item_threshold)
    end
  end
end