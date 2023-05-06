class AddProductToProductBatches < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_batches, :product, null: false, foreign_key: true
  end
end
