class ChangeAssociationsToBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :activities, :creator, :bigint
    change_column :groups,     :creator, :bigint

    change_column :subscriptions, :group_id, :bigint
    change_column :subscriptions, :user_id,  :bigint
  end
end
