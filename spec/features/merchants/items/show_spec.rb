require 'rails_helper'

RSpec.describe 'merchant item show page' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bracelets 'n Stuff")
    @merchant_2 = Merchant.create!(name: "Necklaces 'n Stuff")
    @item_1 = @merchant_1.items.create!(name: "Bracelet", description: "Shiny", unit_price: 1000, status: 0)
    @item_2 = @merchant_1.items.create!(name: "Necklace", description: "Shiny", unit_price: 2000, status: 0)
    @item_3 = @merchant_2.items.create!(name: "Ring", description: "Shiny", unit_price: 3000, status: 0)
  end 

  describe 'when visiting /merchants/merchant_id/items/:item_id' do
    it "US7 displays the item with name, description, unit price" do
      visit merchant_item_path(@merchant_1, @item_1)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.formatted_unit_price)
    end
  end
end