class AddProductBatchIdToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :product_batch, null: false, foreign_key: true
  end
end
