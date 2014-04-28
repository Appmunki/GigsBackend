class Api::V1::RegistrationsController < Devise::RegistrationsController
    skip_before_filter :verify_authenticity_token,
    :if => Proc.new { |c| c.request.format == 'application/json' }
    
    skip_before_filter :verify_authenticity_token

    respond_to :json

    def create
        @resource = Worker.new(params[:user]) if params[:role]=='worker'
        @resource = Employer.new(params[:user]) if params[:role]=='employer' 

        @resource.skip_confirmation!
        if @resource.save
            render :status => 200,
                :json => { :success => true,
                           :info => "Registered",
                           :data => { :email => @resource.email,
                                      :auth_token => @resource.authentication_token } }
            return
        else
          warden.custom_failure!
          render :json=> user.errors, :status=>422
        end
    end
    protected

    def invalid_login_attempt
      render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
    end

end
