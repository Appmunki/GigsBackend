class Api::V1::RegistrationsController < Devise::RegistrationsController
    skip_before_filter :verify_authenticity_token,
    :if => Proc.new { |c| c.request.format == 'application/json' }
    
    skip_before_filter :verify_authenticity_token

    respond_to :json

    def create
        logger.debug  params[:user]
        @resource = Worker.new(params[:user]) if params[:user][:type]=='Worker'
        @resource = Employer.new(params[:user]) if params[:user][:type]=='Employer' 

        @resource.skip_confirmation!
        if @resource.save
            render :status => 200,
                :json => { :success => true,
                           :info => "Registered",
                           :data => @resource }
            return
        else
          warden.custom_failure!
          render :json=> @resource.errors, :status=>422
        end
    end
    protected
    def ensure_params_exist
        return unless params[:user].blank? or params[:user][:email].blank? or params[:user][:password].blank? or params[:user][:password_confirmation].blank?
        render :json=>{:success=>false, :message=>"missing user parameter"}, :status=>422
    end
    def invalid_login_attempt
      render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
    end

end
