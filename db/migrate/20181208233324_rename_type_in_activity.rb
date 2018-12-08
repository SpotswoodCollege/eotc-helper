class RenameTypeInActivity < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :type, :activity_type
  end
end
