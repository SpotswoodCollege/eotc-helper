class ActivitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = Activity.new(activity_params)

    @activity.creator = current_user if user_signed_in?
    @activity.edited_at = @activity.created_at

    if @activity.save
      redirect_to @activity
    else
      render 'new', status: :bad_request
    end
  end

  def update
    @activity = Activity.find(params[:id])

    redirect_to @activity unless would_change(activity_params, @activity)

    @activity.update! activity_params.merge(edited_at: Time.current)
  end

  def approve
    @activity = Activity.find(params[:activity_id])
    authorize! :approve, @activity

    @activity.update! approved_at: Time.current
  end

  private

  def activity_params
    params.require(:activity).permit(:name,
                                     :description,
                                     :activity_type,
                                     :risk,
                                     :groups)
  end

  def would_change(some_params, activity)
    would_change_param(some_params[:name], activity.name) ||
      would_change_param(some_params[:description], activity.description) ||
      would_change_param(some_params[:activity_type], activity.activity_type) ||
      would_change_param(some_params[:risk], activity.risk)
  end

  def would_change_param(param, activity_param)
    !param.nil? && param != activity_param
  end
end
