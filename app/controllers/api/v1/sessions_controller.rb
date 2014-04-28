class Api::V1::SessionsController < Devise::SessionsController
    prepend_before_filter :require_no_authentication, :only => [:create ]
    before_filter :ensure_params_exist

    
    respond_to :json
    skip_before_filter :verify_authenticity_token

    

    def create
        resource = User.find_for_database_authentication(:email => params[:email])
        return invalid_login_attempt unless resource
        if resource.valid_password?(params[:password])
            sign_in("user", resource)
            render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
            return
        end
        invalid_login_attempt
    end

    def destroy
        #sign_out(resource_name)
        logger.debug resource_name
        logger.debug current_user.inspect
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        current_user.update_column(:authentication_token, nil)
        render :status => 200,
            :json => { :success => true,
                       :info => "Logged out",
                       :data => {} }
    end
    protected
    def ensure_params_exist
        return unless params[:email].blank?
        render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
    end

    def invalid_login_attempt
        warden.custom_failure!
        render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
    end
end
