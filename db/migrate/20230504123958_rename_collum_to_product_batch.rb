class RenameCollumToProductBatch < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_batches, :inimum_value, :minimum_value
  end
end
