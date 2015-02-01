class MessageController < ApplicationController
  before_filter :authenticate_user!

  # GET /message/new
  def new
    # display form
  end

  # POST /message/create
  def create
    recipient = User.find(params[:recipient_id])
    current_user.send_message(recipient, params[:body], params[:subject])
  end
end