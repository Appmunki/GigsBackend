class User < ActiveRecord::Base
    acts_as_token_authenticatable
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, :confirmable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :authentication_token
    # attr_accessible :title, :body

    # You likely have this before callback set up for the token.
    before_save :ensure_authentication_token


end
