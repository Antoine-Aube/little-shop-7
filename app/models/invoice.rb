class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants
  validates :customer_id, presence: true
  validates :status, presence: true

  enum :status,["in progress", "completed", "cancelled"]

  def self.incomplete_invoices
    Invoice
    .joins(:invoice_items)
    .select('invoices.*')
    .where.not('invoice_items.status = ?', 2)
    .group('invoices.id')
    .order(:created_at)
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity") / 100.0
  end

  def revenue_for_specific_invoice(merch)
    invoice_items.joins(:item)
    .where("merchant_id = ?", merch.id)
    .sum("invoice_items.quantity*invoice_items.unit_price")/100.0
  end

  def discounts_for_specific_invoice(merch)
    Invoice
    .select("quantity, unit_price, best_discount")
    .from(invoice_items
      .joins(:bulk_discounts)
      .select("invoice_items.id, invoice_items.quantity, invoice_items.unit_price, MAX(bulk_discounts.percentage) as best_discount ")
      .where("invoice_items.quantity >= bulk_discounts.item_threshold AND bulk_discounts.merchant_id = ?", merch.id)
      .group("invoice_items.id"))
      .sum("quantity*unit_price*best_discount/100.0")
  end

  def discounted_revenue_for_specific_invoice(merch)
    revenue_for_specific_invoice(merch) - discounts_for_specific_invoice(merch)
  end

  def discounts_for_specific_invoice_admin
    Invoice
    .select("quantity, unit_price, best_discount")
    .from(invoice_items
      .joins(:bulk_discounts)
      .select("invoice_items.id, invoice_items.quantity, invoice_items.unit_price, MAX(bulk_discounts.percentage) as best_discount ")
      .where("invoice_items.quantity >= bulk_discounts.item_threshold")
      .group("invoice_items.id"))
      .sum("quantity*unit_price*best_discount/100.0")
  end

  def discounted_revenue_for_specific_invoice_admin
    total_revenue - discounts_for_specific_invoice_admin
  end
end


