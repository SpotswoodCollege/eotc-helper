# Links Activities to Groups.
class Assignment < ApplicationRecord
  belongs_to :activity
  belongs_to :group

  validates :group_id, uniqueness: { scope: :activity_id }

  def owned_by?(user)
    user.in? [activity.creator, group.creator]
  end
end
