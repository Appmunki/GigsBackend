class AddGigsToUser < ActiveRecord::Migration
  def change
    add_column :users, :gig_id, :integer
  end
end
