class CreateProductBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :product_batches do |t|
      t.string :code
      t.datetime :start_date
      t.datetime :deadline
      t.decimal :inimum_value
      t.decimal :minimal_difference
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
