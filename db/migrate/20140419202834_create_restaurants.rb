class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :title
      t.string :description
      t.float :rating

      t.timestamps
    end
  end
end
