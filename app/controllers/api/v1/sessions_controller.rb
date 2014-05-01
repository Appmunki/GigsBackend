class Api::V1::SessionsController < Devise::SessionsController
    acts_as_token_authentication_handler_for User
    before_filter :authenticate_user!


    respond_to :json

    

    def create
        resource = User.find_for_database_authentication(:email => params[:user][:email])
        return invalid_login_attempt unless resource
        if resource.valid_password?(params[:user][:password])
            sign_in("user", resource)
            render :json=> {:success=>true, :info => "Logged in", :user=>resource }
            return
        end
        invalid_login_attempt
    end

    def destroy
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        current_user.update_column(:authentication_token, nil)
        render :status => 200,
            :json => { :success => true,
                       :info => "Logged out",
                       :data => {} }
    end
    protected
    
    def ensure_params_exist
        return unless params[:user].blank? or params[:user][:email].blank? or params[:user][:password].blank?
        render :json=>{:success=>false, :message=>"missing user parameter"}, :status=>422
    end

    def invalid_login_attempt
        warden.custom_failure!
        render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
    end
end
