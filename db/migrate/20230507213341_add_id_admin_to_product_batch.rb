class AddIdAdminToProductBatch < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_batches, :admin, null: false, foreign_key: true, default: 0
  end
end
