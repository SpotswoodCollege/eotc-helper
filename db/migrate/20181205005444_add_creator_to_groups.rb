class AddCreatorToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :creator, :integer
  end
end
