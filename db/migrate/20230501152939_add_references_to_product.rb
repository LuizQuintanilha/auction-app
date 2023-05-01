class AddReferencesToProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :category, null: false, foreign_key: true, default: 0
  end
end
