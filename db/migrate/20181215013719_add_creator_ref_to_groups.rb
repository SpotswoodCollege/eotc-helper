class AddCreatorRefToGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference   :groups, :creator
    add_foreign_key :groups, :users, column: :creator_id
  end
end
