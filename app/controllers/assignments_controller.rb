class AssignmentsController < ApplicationController
  def index
    @assignments = Assignment.all
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @activity = @assignment.activity

    if @assignment.save
      redirect_to @activity,
                  notice: I18n.t('labels.assignment.created',
                                 activity_name: @activity.name)
    else
      render @activity || activities_path, status: :bad_request
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @activity = @assignment.activity
    @assignment.destroy

    redirect_to @activity,
                notice: I18n.t('labels.assignment.destroyed',
                               activity_name: @activity.name)
  end

  private

  def assignment_params
    params.permit(:activity_id, :group_id)
  end
end
