class GroupsController < ApplicationController
  load_and_authorize_resource

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)

    @group.creator = current_user.id if user_signed_in?

    if @group.save
      redirect_to @group
    else
      render 'new', status: :bad_request
    end
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to @group
    else
      render 'edit', status: :bad_request
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
