class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item
  has_one :merchant, through: :item
  
  validates :invoice_id, presence: true
  validates :item_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum :status,["packaged", "pending", "shipped"]

  def unit_price_to_decimal
    unit_price / 100.0
  end

  def applied_discount
    item.merchant.bulk_discounts.where('item_threshold <= ?', quantity)
                                .order(percentage: :desc)
                                .first
  end
end


