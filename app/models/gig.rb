class Gig < ActiveRecord::Base
	belongs_to :employer, :class_name => 'Employer'
	has_one :worker, :class_name => 'Worker'
	attr_accessible :description, :status, :title,:latitude,:longitude

	validates_presence_of :title, :status
end
