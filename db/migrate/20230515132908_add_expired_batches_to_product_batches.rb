class AddExpiredBatchesToProductBatches < ActiveRecord::Migration[7.0]
  def change
    add_column :product_batches, :expired, :boolean, default: false
  end
end
