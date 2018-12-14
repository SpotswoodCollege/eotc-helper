# Defines a User. Users can have roles.
class User < ApplicationRecord
  ROLES = %i[standard
             teacher
             senior_teacher
             coordinator
             principal
             board
             administrator].freeze

  ROLE_GROUPS = {
    standard: %i[standard],
    staff: %i[teacher senior_teacher coordinator principal],
    teachers: %i[teacher senior_teacher coordinator],
    principals: %i[principal],
    board: %i[board],
    administrators: %i[administrator]
  }.freeze

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :role, presence: true,
                   inclusion: { in: ROLES,
                                message: I18n.t('error.brief.valid_rel',
                                                rel: 'role') }

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

    role == other_role
  end

  def of_group?(group)
    group = group.to_sym

    # If the given group is not valid, raise
    # REVIEW: Should this use I18n?
    raise "No such group #{group}" unless group.in? ROLE_GROUPS.keys

    role.in? ROLE_GROUPS[group]
  end

  has_many :subscriptions, dependent: :destroy
  has_many :groups, -> { distinct }, through: :subscriptions

  has_many :activities, through: :groups
end
