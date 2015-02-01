class Api::V1::GigsController < ApplicationController
    
     # Just skip the authentication for now
    acts_as_token_authentication_handler_for User

    respond_to :json
    
    def index
        if current_user.type !='Employer'
            render :status => 401,
            :json => { :success => false,
                       :info => "This user type cannot use this action",
                       :data => {} }
            return
        end
        render :status => 200,
        :json => { :success => true,
                       :info => "Employer's Gigs",
                       :data => current_user.gigs }
    end

    def show
        @gig = Gig.find(params[:id])
        render :status => 200,
        :json => { :success => true,
                       :info => "Gig",
                       :data => @gig }
    end

    def create
        logger.debug current_user.inspect
        if current_user.type !='Employer'
            render :status => 401,
            :json => { :success => false,
                       :info => "This user type cannot use this action",
                       :data => {} }
            return

        end
        #todo finish having gig created by employer
        @gig = Gig.new(params[:gig])
        @gig.employer = current_user
        if @gig.save!
            render :status => 200,
            :json => { :success => true,
                       :info => "Gig Created",
                       :data => @gig }
        else
            render :status => 401,
            :json => { :success => false,
                       :info => "Failed to create gig",
                       :data => {} }
        end 
    end

    

    def assign
        #checking if the current user is an employer
        if current_user.type !='Employer'
            render :status => 401,
            :json => { :success => false,
                       :info => "This user type cannot use this action",
                       :data => {} }
            return
        end
        #check for the params
        if !params.has_key?(:worker_id) or !params.has_key?(:gig_id)
            render :status => 401,
            :json => { :success => false,
                       :info => "Cannot find this worker id or gig id",
                       :data => {} }
            return
        end

        #checking to see if the worker and gigs are in the
        @worker = Worker.find(params[:worker_id])
        @gig = current_user.gigs.find(params[:gig_id])

        if !@worker.present? or !@gig.present?
            render :status => 401,
            :json => { :success => false,
                       :info => "Cannot find this worker or gig",
                       :data => {} }
            return
        end

        #assign worker to gig and attempt to save
        logger.debug @gig.inspect
        @gig.worker = @worker
        if @gig.save
            render :status => 200,
            :json => { :success => true,
                       :info => "This gig has been assigned",
                       :data => { :gig => @gig, :worker => @gig.worker } }
            return
        else
            render :status => 401,
            :json => { :success => false,
                       :info => "Failed to assign gig",
                       :data => {} }
        end           

    end

end