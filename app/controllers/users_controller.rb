# The UsersController class controls User objects.
# @todo Add tests for signup / settings
class UsersController < ApplicationController
  # Show a user profile page
  # @todo Update route for user profile page
  def show
    @user = current_user
  end

  # Show the form for a new user
  def new
    @user = User.new
  end

  # Create a new user from parameters
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to settings_path
    else
      render 'new'
    end
  end

  private

  # (private) Get user parameters
  # Returns name, email, password, password_confirmation
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
