# The UsersController class controls User objects.
class UsersController < ApplicationController
  # Show a user profile page
  # @todo Update route for user profile page
  def show
    @user = User.find(params[:id])
  end

  # Add a new user
  def new
    @user = User.new
  end

  # Create a user
  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
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
