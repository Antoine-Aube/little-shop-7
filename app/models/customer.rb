class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_customer
    Customer
    .select('customers.*, count(transactions.id) as transaction_count')
    .joins(invoices: :transactions)
      .where('transactions.result = ?', 1)
      .group('customers.id')
      .order(transaction_count: :desc)
      .limit(5)
  end
end