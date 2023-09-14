class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  
  validates :name, presence: true

  def top_five_customers
    self.customers
      .select('customers.*, count(DISTINCT transactions.*) AS transaction_count')
      .where('transactions.result = 1')
      .joins(invoices: :transactions)
      .group('customers.id')
      .order(transaction_count: :desc)
      .limit(5)
  end
  
  def self.enabled
    where(enabled: true)
  end

  def self.disabled
    where(enabled: false)
  end
end
