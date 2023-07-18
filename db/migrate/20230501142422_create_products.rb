class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :photo
      t.integer :weight
      t.integer :width
      t.integer :height
      t.integer :depth
      t.string :description
      t.string :code

      t.timestamps
    end
  end
end
