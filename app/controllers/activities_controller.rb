class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)

    @activity.creator = current_user.id if user_signed_in?

    if @activity.save
      redirect_to @activity
    else
      render 'new', status: :bad_request
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :activity_type, :risk)
  end
end
