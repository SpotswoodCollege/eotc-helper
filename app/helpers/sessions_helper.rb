# Helper module for Sessions
module SessionsHelper
  # Log in the given User
  # Does not return a value
  def log_in(user)
    session[:user_id] = user.id
  end

  # Log out the current User
  # Does not return a value
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Return the current user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if a user is logged in, otherwise false
  def logged_in?
    !current_user.nil?
  end
end
