class AddLocationToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :longitude, :float
    add_column :gigs, :latitude, :float
  end
end
