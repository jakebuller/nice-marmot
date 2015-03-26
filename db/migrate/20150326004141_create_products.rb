class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.boolean :available
      t.string :purchase_link
      t.string :image_link

      t.timestamps null: false
    end
  end
end
