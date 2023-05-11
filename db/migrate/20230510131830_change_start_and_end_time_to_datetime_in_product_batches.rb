class ChangeStartAndEndTimeToDatetimeInProductBatches < ActiveRecord::Migration[7.0]
  def change
    change_column :product_batches, :start_time, :datetime
    change_column :product_batches, :end_time, :datetime
  end
end
