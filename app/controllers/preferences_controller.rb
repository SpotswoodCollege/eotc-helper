class PreferencesController < ApplicationController
  def show
    redirect_to root_path unless user_signed_in?
  end

  def update
    current_user.update! preference_params
  end

  private

  def preference_params
    params.require(:preferences).permit(:notification_policy)
  end
end
