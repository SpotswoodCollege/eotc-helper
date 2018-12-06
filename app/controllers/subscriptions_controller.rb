class SubscriptionsController < ApplicationController
  def index
    raise 'Must be logged in' unless user_signed_in?

    @subscriptions = Subscription.where user_id: current_user.id
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @group = @subscription.group

    if @subscription.save
      redirect_to @subscription.group,
                  notice: I18n.t('subscriptions.created',
                                 group_name: @group.name)
    else
      render @subscription.group || groups_path, status: :bad_request
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @group = @subscription.group
    @subscription.destroy

    redirect_to @group,
                notice: I18n.t('subscriptions.destroyed',
                               group_name: @group.name)
  end

  private

  def subscription_params
    params.permit(:user_id, :group_id)
  end
end
