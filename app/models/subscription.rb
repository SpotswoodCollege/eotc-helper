class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user,  presence: { message: 'must belong to a user' }
  validates :group, presence: { message: 'must belong to a group' }
end
