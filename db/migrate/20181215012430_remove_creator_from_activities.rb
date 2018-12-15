class RemoveCreatorFromActivities < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :creator, :bigint
  end
end
