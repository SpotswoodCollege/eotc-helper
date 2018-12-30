# Defines a User. Users can have roles.
class User < ApplicationRecord
  # TODO: Move to config?
  ROLES = %i[standard
             teacher
             senior_teacher
             coordinator
             principal
             board
             administrator].freeze
  ROLE_STRINGS = ROLES.each(&:to_s).freeze

  # TODO: Move to config?

  ROLE_GROUPS = {
    standard: %i[standard],
    staff: %i[teacher senior_teacher coordinator principal],
    teachers: %i[teacher senior_teacher coordinator],
    principals: %i[principal],
    coordinators: %i[coordinator principal],
    board: %i[board],
    administrators: %i[administrator]
  }.freeze
  ROLE_GROUP_STRINGS = ROLE_GROUPS.each(&:to_s).freeze

  NOTIFICATION_POLICIES = %i[all
                             only_subscribed
                             none].freeze
  NOTIFICATION_POLICY_STRINGS = NOTIFICATION_POLICIES.each(&:to_s).freeze

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :role, presence: true,
                   inclusion: { in: ROLE_STRINGS,
                                message: I18n.t('error.brief.valid_rel',
                                                rel: 'role') }

  validates :notification_policy, presence: true,
                                  inclusion: { in: NOTIFICATION_POLICY_STRINGS,
                                               message: I18n.t('error.brief.valid_rel',
                                                               rel: 'notification policy') }

  has_many :subscriptions, dependent: :destroy
  has_many :groups, -> { distinct }, through: :subscriptions

  has_many :activities, through: :groups

  has_many :created_activities,
           class_name: 'Activity',
           inverse_of: :creator,
           foreign_key: :creator_id,
           dependent: :nullify

  has_many :created_groups,
           class_name: 'Group',
           inverse_of: :creator,
           foreign_key: :creator_id,
           dependent: :nullify

  # Is the user's role greater than or equal to the given role?
  def role_greater_or_equal_to?(other_role)
    other_role = other_role.to_sym || ''

    # If the given role is not valid, raise
    # REVIEW: Should this use I18n?
    raise "No such role #{other_role}" unless ROLES.include? other_role

    other_role_index = ROLES.index other_role
    role_index       = ROLES.index role.to_sym

    role_index >= other_role_index
  end

  alias role_gte? role_greater_or_equal_to?

  def role?(other_role)
    other_role = other_role.to_sym || ''

    # If the given role is not valid, raise
    # REVIEW: Should this use I18n?
    raise "No such role #{other_role}" unless other_role.in? ROLES

    role.to_sym == other_role
  end

  def of_group?(group)
    group = group.to_sym

    # If the given group is not valid, raise
    # REVIEW: Should this use I18n?
    raise "No such group #{group}" unless group.in? ROLE_GROUPS.keys

    role.to_sym.in? ROLE_GROUPS[group]
  end

  def t_role
    I18n.t("labels.user.role.#{role}")
  end

  def should_be_notified_by?(activity)
    notification_policy == 'all' || (notification_policy == 'only_subscribed' && activity.in?(groups))
  end
end
