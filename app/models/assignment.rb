class Assignment < ApplicationRecord
  belongs_to :activity
  belongs_to :group

  validates :group_id, uniqueness: { scope: :activity_id }
end
