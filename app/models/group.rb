class Group < ApplicationRecord
  validates :name, unique: true
end
