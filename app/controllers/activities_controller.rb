class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
  end

  def show
    @group = Group.find(params[:id])
  end
end
