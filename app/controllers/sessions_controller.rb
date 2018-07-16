# The SessionsController class controls sessions. A session is a logged-in
# client.
# @todo Add tests for login / logout
class SessionsController < ApplicationController
  # Show the view for creating a session (logging in). Redirects to
  # settings_path if already logged in.
  # Does not return a value.
  def new
    redirect_to settings_path if logged_in?
  end

  # Create a Session object, logging in the accociated user.
  # Does not return a value.
  def create
    session_params = params[:session]
    user = User.find_by(email: session_params[:email].downcase)
    if user_valid? session_params, user
      log_in user
      remember_or_forget session_params, user
      redirect_to settings_path
    else
      flash.now[:danger] = 'Incorrect password'
      render 'new'
    end
  end

  # Destroy a Session object, logging out the user associated.
  # Does not return a value.
  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  private

  # (private) Is the given user valid?
  # Returns true if yes, false otherwise.
  def user_valid?(session_params, user)
    user && user.authenticate(session_params[:password])
  end

  # (private) Remember or forget the given user based on their preference.
  # Does not return a value.
  def remember_or_forget(session_params, user)
    session_params[:remember_me] == '1' ? remember(user) : forget(user)
  end
end
