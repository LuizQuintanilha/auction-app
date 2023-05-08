class AddCreatedAndApprovedByToProductBatches < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_batches, :created_by
    add_reference :product_batches, :approved_by
  end
end
