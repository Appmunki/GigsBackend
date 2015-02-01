class AddTypeToUser < ActiveRecord::Migration
    def self.up
        change_table :users do |t|
            t.string :type
        end
    end
end
