require 'net/http'
require 'json'
require 'uri'

class User < ActiveRecord::Base
    acts_as_token_authenticatable
    acts_as_messageable
    after_save :quick_blok_save


    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, :confirmable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :type,:username,:name, :email, :password, :password_confirmation, :remember_me, :authentication_token
    # attr_accessible :title, :body

    def quick_block_save
		  #req = Net::HTTP::Post.new uri

    end
end
