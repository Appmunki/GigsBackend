class AddEmployerIdToGig < ActiveRecord::Migration
  def change
  	add_column :gigs, :worker_id, :integer
  	add_column :gigs, :employer_id, :integer
  end
end
