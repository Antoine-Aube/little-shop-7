class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :percentage, presence: true, numericality: { greater_than: 0, less_than: 1 }
  validates :item_threshold, presence: true, numericality: { greater_than: 0 }
end