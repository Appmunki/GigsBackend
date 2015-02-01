class Api::V1::WorkersController < ApplicationController

respond_to :json

# GET /Workers/1
# GET /Workers/1.json
def show
	Logger.log current_user
    @worker = Worker.find(params[:id])
    render json: @worker
end


end