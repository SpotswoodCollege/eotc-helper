class Activity < ApplicationRecord
  has_many :assignments
  has_many :groups, through: :assignments

  has_many :users, through: :groups

  def can_be_approved_by?(_user)
    true
  end

  def approved?
    return false if approved_at.nil?
    approved_at >= (edited_at || created_at)
  end
end
