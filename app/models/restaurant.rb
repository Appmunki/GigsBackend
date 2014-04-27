class Restaurant < ActiveRecord::Base
  attr_accessible :description, :rating, :title
end
