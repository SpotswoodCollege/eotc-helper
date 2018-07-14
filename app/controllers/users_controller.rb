# This controller describes the behaviour of Users, and is accessed through the
# /users route.
class UsersController < ApplicationController
  # Show the page of a given User
  # TODO: Remove this method; replace with a /settings page
  def show
    @user = User.find(params[:id])
  end

  # Make a new User
  def new
    @user = User.new
  end

  # Create a User
  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

  # Get the parameters of a User
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
