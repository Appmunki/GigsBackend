class Api::V1::SessionsController < Devise::SessionsController
    skip_before_filter :verify_authenticity_token,
        :if => Proc.new { |c| c.request.format == 'application/json' }

    respond_to :json

    def new
        logger.debug "Session New"
        logger.debug params
    end

    def create
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        render :status => 200,
            :json => { :success => true,
                       :info => "Logged in",
                       :data => { :auth_token => current_user.authentication_token } }
    end

    def destroy
        logger.debug "Delete"
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        current_user.update_column(:authentication_token, nil)
        render :status => 200,
            :json => { :success => true,
                       :info => "Logged out",
                       :data => {} }
    end

    def failure
        render :status => 401,
            :json => { :success => false,
                       :info => "Login Failed",
                       :data => {} }
    end
end
