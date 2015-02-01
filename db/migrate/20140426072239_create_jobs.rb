class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :status
      t.integer :worker_id
      t.integer :employer

      t.timestamps
    end
  end
end
