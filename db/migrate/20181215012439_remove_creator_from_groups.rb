class RemoveCreatorFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :creator, :bigint
  end
end
