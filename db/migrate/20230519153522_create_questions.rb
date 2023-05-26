class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :product_batch, null: false, foreign_key: true
      t.boolean :hidden, default: false

      t.timestamps
    end
  end
end
