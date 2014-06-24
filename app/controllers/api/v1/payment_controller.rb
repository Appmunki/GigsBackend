class Api::V1::PaymentController < ApplicationController

 # Just skip the authentication for now
    # acts_as_token_authentication_handler_for User

    # respond_to :json

    helper_method :mailbox, :conversation

	def new
    p "new"
  end

def create
  # Amount in cents
 
  Stripe.api_key = "sk_test_khwQNFLXJ3HAl2jsxoGduL3B"
  # p gig

  @amount = params[:amount]

  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:token]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails ANDROID',
    :currency    => 'usd'
  )

  status = charge[:paid]

  if status==true
    Gig.transaction do
      gig = Gig.lock.find(params[:gigId])
      gig.status = 'Payed'
      gig.save
    end

  # newgig = Gig.new(:title => "baz", :status => "status")
  # newgig.save


  gig = Gig.find(params[:gigId])

  worker = User.find(gig.worker_id);
  employer = User.find(gig.employer_id);

  
  # employer.send_message(worker, "Payment done", "Payment")

  ActionMailer::Base.mail(:from => "me@example.com", :to => "amdgerman@gmail.com", :subject => "test", :body => "test").deliver

end


# p Stripe::Charge.retrieve(charge[:id]);

render :json => charge

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end





end
