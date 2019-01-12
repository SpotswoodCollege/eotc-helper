# TODO: Use `respond_to`
class AssignmentsController < ApplicationController
  load_and_authorize_resource

  def index
    @assignments = Assignment.all
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @activity = @assignment.activity

    # REVIEW: Should redirects go here?
    # REVIEW: I think this should use Ajax for something like the Github tags
    #           menu
    @assignment.save!
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @activity = @assignment.activity
    @assignment.destroy

    # REVIEW: Should this redirect?
    redirect_to @activity,
                notice: I18n.t('labels.assignment.destroyed',
                               activity_name: @activity.name)
  end

  private

  def assignment_params
    params.require(:assignment).permit(:activity_id, :group_id)
  end
end
