class Group < ApplicationRecord
  validates :name, presence: { message: "can't be blank" },
                   uniqueness: { message: 'must be unique' }
end
