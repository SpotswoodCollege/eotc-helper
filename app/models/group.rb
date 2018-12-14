class Group < ApplicationRecord
  validates :name, presence:   { message: I18n.t('error.brief.no_blank') },
                   uniqueness: { message: I18n.t('error.brief.unique') }

  validates :creator, presence: { message: I18n.t('error.brief.log_in') }

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  # has_many :assignments
  # has_many :activities, through: :assignments
end
