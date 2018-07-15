# The SessionsController class controls sessions. A session is a logged-in
# client.
# @todo Add tests for login / logout
class SessionsController < ApplicationController
  def new; end

  # Create a Session object
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user_valid? user
      log_in user
      redirect_to settings_path
    else
      flash.now[:danger] = 'Incorrect password'
      render 'new'
    end
  end

  # Destroy a Session object
  def destroy
    log_out
    redirect_to login_path
  end

  private

  def user_valid?(user)
    user && user.authenticate(params[:session][:password])
  end
end
