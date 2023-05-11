class AddCollumToProductBatches < ActiveRecord::Migration[7.0]
  def change
    add_column :product_batches, :start_time, :time
    add_column :product_batches, :end_time, :time
  end
end
