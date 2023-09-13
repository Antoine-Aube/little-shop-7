class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  validates :customer_id, presence: true
  validates :status, presence: true

  enum :status,["in progress", "completed", "cancelled"]

  def self.incomplete_invoices
    Invoice
    .joins(:invoice_items)
    .select('invoices.*')
    .where.not('invoice_items.status = ?', 2)
    .group('invoices.id')
    .order(:id)
  end
  
  def self.group_by_id
    group(:id)
  end
end
