require 'net/http'
require 'json'
require 'uri'
require 'hmac-sha1'

class User < ActiveRecord::Base
    acts_as_token_authenticatable
    acts_as_messageable
    after_save :quick_blok_save


    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :type,:username,:name, :email, :password, :password_confirmation, :remember_me, :authentication_token
    # attr_accessible :title, :body

    def generate_session
      blox = Quickblox.new

      application_id = 10040
      auth_key = 'XzYyN73N2UkgekP'
      auth_secret = 'dkv4fZmCvRv6GrH'
      nonce = Random.rand(1000...9999)
      timestamp =  Time.now.to_i

      token = blox.get_token
      logger.debug "token #{token}"
      token
    end
    def showpassword
      puts self.password
    end
    def quick_blok_save

      blox = Quickblox.new
      results=blox.signup_user(:user=>{:login=>self.username,:password=>self.password,:email=>self.email,:tag_list=>self.user_type})

      puts "results #{results}"
      #todo do something if this fails

    end
    def skip_confirmation!
      self.confirmed_at = Time.now
    end
end
