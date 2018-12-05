class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    @group.creator = current_user.id if user_signed_in?

    if @group.save
      redirect_to @group
    else
      render 'new'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
