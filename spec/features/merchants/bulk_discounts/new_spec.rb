require 'rails_helper'

RSpec.describe 'New Bulk Discount' do
  describe "#new" do 
    it "has a form to create a new bulk discount" do
      @merchant1 = Merchant.create!(name: 'Liberty Heights Fresh')
      visit new_merchant_bulk_discount_path(@merchant1)
      expect(@merchant1.bulk_discounts).to eq([])

      expect(page).to have_content("Create a new discount")
      expect(page).to have_field(:name)
      expect(page).to have_field(:percentage) 
      expect(page).to have_field(:item_threshold)
      expect(page).to have_button("Create Discount")
    end

    it "creates a new bulk discount when all fields are filled in correctly" do 
      @merchant1 = Merchant.create!(name: 'Liberty Heights Fresh')
      visit new_merchant_bulk_discount_path(@merchant1)

      fill_in(:name, with: "10% off 10 items")
      fill_in(:percentage, with: 0.10)
      fill_in(:item_threshold, with: 10)
      click_button("Create Discount")
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

      new_discount = @merchant1.bulk_discounts.last
      expect(@merchant1.bulk_discounts).to eq([new_discount])
      
      within("#discount-#{new_discount.id}") do
        expect(page).to have_content("10% off 10 items")
        expect(page).to have_content("10")  
        expect(page).to have_content("10%")
      end 
    end

    it "displays an error message when a field is missing" do
      @merchant1 = Merchant.create!(name: 'Liberty Heights Fresh')
      visit new_merchant_bulk_discount_path(@merchant1)

      fill_in(:name, with: "10% off 10 items")
      fill_in(:percentage, with: "")
      fill_in(:item_threshold, with: 10)
      click_button("Create Discount")

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      expect(page).to have_content("Discount not created: Required information missing.")
    end
  end
end