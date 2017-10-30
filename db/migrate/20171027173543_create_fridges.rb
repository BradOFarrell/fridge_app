class CreateFridges < ActiveRecord::Migration[5.1]
  def change
    create_table :fridges do |t|
      t.string :location
      t.string :brand
      t.integer :size
      t.boolean :has_food
      t.boolean :has_drink

      t.timestamps
    end
  end
end
