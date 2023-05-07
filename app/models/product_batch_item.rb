class ProductBatchItem < ApplicationRecord
  belongs_to :product_batch
  belongs_to :product
end
