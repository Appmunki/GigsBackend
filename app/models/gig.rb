class Gig < ActiveRecord::Base
	belongs_to :employer, :class_name => 'User',
        :conditions => {:type => 'Wmployer'}
	has_one :worker, :class_name => 'User',
        :conditions => {:type => 'Worker'}
	attr_accessible :description, :status, :title

	validates_presence_of :title, :status
end
