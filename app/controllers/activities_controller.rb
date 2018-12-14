class ActivitiesController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource only: :update

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

    @activity.creator = current_user.id if user_signed_in?
    @activity.edited_at = @activity.created_at

    if @activity.save
      redirect_to @activity
    else
      render 'new', status: :bad_request
    end
  end

  def update
    @activity = Activity.find(params[:id])

    if activity_params[:approve] == 'true'
      update_approve
    elsif would_change(activity_params_no_approve, @activity)
      update_update
    else
      redirect_to @activity || activities_path
    end
  end

  private

  # Edit activity
  def update_update
    authorize! :update, @activity

    if @activity.update(activity_params_no_approve, edited_at: Time.current)
      redirect_to @activity
    else
      render 'edit', status: :bad_request
    end
  end

  # Approve activity
  def update_approve
    authorize! :approve, @activity

    if @activity.update(approved_at: Time.current)
      redirect_to @activity
    else
      render 'edit', status: :bad_request
    end
  end

  def activity_params
    params.require(:activity).permit(:name,
                                     :description,
                                     :activity_type,
                                     :risk,
                                     :approve)
  end

  def activity_params_no_approve
    params.require(:activity).permit(:name,
                                     :description,
                                     :activity_type,
                                     :risk)
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
