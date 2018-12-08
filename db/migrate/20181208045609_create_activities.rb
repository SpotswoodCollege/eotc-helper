class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :type
      t.string :risk
      t.datetime :edited_at
      t.datetime :approved_at
      t.datetime :occurs_at
      t.datetime :finishes_at
      t.integer :creator

      t.timestamps
    end
    add_index :activities, :name, unique: true
  end
end
