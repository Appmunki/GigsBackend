class User < ActiveRecord::Base
    acts_as_token_authenticatable
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, :confirmable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :type,:name, :email, :password, :password_confirmation, :remember_me, :authentication_token
    # attr_accessible :title, :body


end
