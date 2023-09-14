require 'rails_helper'

RSpec.describe 'merchant item edit page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bracelets 'n Stuff")
    @merchant_2 = Merchant.create!(name: "Necklaces 'n Stuff")
    @item_1 = @merchant_1.items.create!(name: "Bracelet", description: "Shiny", unit_price: 1000, status: 0)
    @item_2 = @merchant_1.items.create!(name: "Necklace", description: "Shiny", unit_price: 2000, status: 0)
    @item_3 = @merchant_2.items.create!(name: "Ring", description: "Shiny", unit_price: 3000, status: 0)
  end 

  describe 'when visiting /merchants/merchant_id/items/:item_id/edit' do
    it "US8 shows a form to edit the item and it's attributes" do 
      visit edit_merchant_item_path(@merchant_1, @item_1)

      expect(page).to have_content("Edit #{@item_1.name}")
      expect(page).to have_field(:name, with: @item_1.name)
      expect(page).to have_field(:description, with: @item_1.description)
      expect(page).to have_field(:unit_price, with: @item_1.unit_price)
      expect(page).to have_button("Update Item")

      fill_in(:name, with: "Not Bracelet")
      fill_in(:description, with: "Not Shiny")
      fill_in(:unit_price, with: 5000)

      click_button("Update Item")

      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
      expect(page).to have_content("Not Bracelet")
      expect(page).to have_content("Not Shiny")
      expect(page).to have_content("$50.00")
    end
  end
end