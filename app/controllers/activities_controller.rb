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

    if activity_params[:approve] == true
      # Approve activity
      @activity.approved_at = Time.now if activity_params[:approve] == true &&
                                          can?(:approve, @activity)
      if @activity.update
        redirect_to @activity
      else
        render 'edit', status: :bad_request
      end
    elsif would_change(activity_params_no_approve, @activity)
      # Edit activity
      @activity.edited_at = Time.now

      if @activity.update(activity_params_no_approve)
        redirect_to @activity
      else
        render 'edit', status: :bad_request
      end
    else
      redirect_to @activity || activities_path
    end
  end

  private

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
