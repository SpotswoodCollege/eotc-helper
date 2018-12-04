class AddDefaultForUserRole < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :role, 'standard'
  end
end
