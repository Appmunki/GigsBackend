class Api::V1::RegistrationsController < Devise::RegistrationsController
    skip_before_filter :verify_authenticity_token,
    :if => Proc.new { |c| c.request.format == 'application/json' }

    respond_to :json

    def create
        logger.debug params
        @resource = Worker.new(params[:user]) if params[:role]=='worker'
        @resource = Employer.new(params[:user]) if params[:role]=='employer' 

        @resource.skip_confirmation!
        if @resource.save
            sign_in @resource
            render :status => 200,
                :json => { :success => true,
                           :info => "Registered",
                           :data => { :user => @resource,
                                      :auth_token => @resource.authentication_token } }
        else
            render :status => :unprocessable_entity,
                :json => { :success => false,
                           :info => @resource.errors,
                           :data => {} }
        end
    end

end
