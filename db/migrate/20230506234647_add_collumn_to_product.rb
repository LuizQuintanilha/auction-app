class AddCollumnToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :status, :integer, default: 2
  end
end
