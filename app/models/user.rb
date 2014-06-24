require 'net/http'
require 'json'
require 'uri'
require 'hmac-sha1'

class User < ActiveRecord::Base
    acts_as_token_authenticatable
    acts_as_messageable


    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :type,:username,:email, :password, :password_confirmation, :remember_me, :authentication_token,:latitude,:longitude

    def skip_confirmation!
      self.confirmed_at = Time.now
    end

    def mailboxer_email(object)
      return email
    end
end
