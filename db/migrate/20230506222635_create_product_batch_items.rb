class CreateProductBatchItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_batch_items do |t|
      t.references :product_batch, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
