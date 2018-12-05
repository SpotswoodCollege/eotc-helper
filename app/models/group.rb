class Group < ApplicationRecord
  validates :name, presence: { message: "can't be blank" },
                   uniqueness: { message: 'must be unique' }

  validates :creator, presence: { message: 'must be logged in' }

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  # has_many :assignments
  # has_many :activities, through: :assignments
end
