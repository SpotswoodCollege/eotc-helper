# The SessionsController class controls sessions. A session is a logged-in
# client.
class SessionsController < ApplicationController
  def new; end

  # Create a Session object
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Incorrect password'
      render 'new'
    end
  end

  def destroy; end
end
