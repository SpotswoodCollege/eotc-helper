class AddCreatorRefToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference   :activities, :creator
    add_foreign_key :activities, :users, column: :creator_id
  end
end
