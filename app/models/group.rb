class Group < ApplicationRecord
  validates :name, presence:   { message: I18n.t('error.brief.no_blank') },
                   uniqueness: { message: I18n.t('error.brief.unique') }

  validates :creator, presence: { message: I18n.t('error.brief.log_in') }

  has_many :subscriptions, dependent: :destroy
  has_many :users, -> { distinct }, through: :subscriptions

  has_many :assignments, dependent: :destroy
  has_many :activities, -> { distinct }, through: :assignments

  belongs_to :creator,
             class_name: 'User',
             foreign_key: :creator_id,
             inverse_of: :created_groups
end
