class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.string :title
      t.text :description
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
