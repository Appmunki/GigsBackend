class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :authenticate_user!
    before_filter :authenticate_user
	private
		def authenticate_user
			if authenticate_user_from_secret_key
		  		return true
			else
		  		head :unauthorized 
			end
		end
		def authenticate_user_from_secret_key
			userid = ApiAuth.access_id(request)
			currentuser = userid && User.find_by_id(userid)
			if ApiAuth.authentic?(request, currentuser.find_api_key.secret_key)
		  		return true
			else
		  		return false
			end
			false
		end
end
