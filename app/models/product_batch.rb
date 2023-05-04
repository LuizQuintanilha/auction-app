class ProductBatch < ApplicationRecord
  validates :code, :start_date, :deadline, :minimum_value, :minimal_difference, presence: true
end
