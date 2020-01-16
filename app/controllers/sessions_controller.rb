class SessionsController < ApplicationController
  after_action :checkin, only: :create
  before_action :checkout, only: :destroy

  def new
  end

  def index
    @sessions = Session.all
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def checkin
    session = Session.new(email: params[:session][:email].downcase, 
                          checkin: Time.now.strftime("%Y-%m-%d %H-%M"), checkout: nil)
    session.save!
  end

  def checkout
    user = User.find_by(id: session[:user_id])
    session = Session.new(email: user.email, checkin: nil, checkout: Time.now.strftime("%Y-%m-%d %H-%M"))
    session.save!
  end

end
