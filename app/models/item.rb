class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  validates :name, presence: true
  validates :description, presence: true 
  validates :unit_price, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true
  
  enum :status,["disabled", "enabled"]

  def formatted_unit_price
    dollars = unit_price / 100.0
    formatted = sprintf('%.2f', dollars)
    "$#{formatted}"
  end
end
