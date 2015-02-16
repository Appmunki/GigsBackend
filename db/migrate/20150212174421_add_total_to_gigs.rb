class AddTotalToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :total_price, :float
  end
end
