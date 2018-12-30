class AddDefaultNotificationPolicy < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :notification_policy, 'only_subscribed'
  end
end
