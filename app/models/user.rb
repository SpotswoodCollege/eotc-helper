# Defines a User. Users can have roles.
class User < ApplicationRecord
  ROLES = %w[standard teacher coordinator administrator].freeze

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :role, presence: true,
                   inclusion: { in: ROLES,
                                message: 'must be a valid role' }

  # Is the user's role greater than or equal to the given role?
  def role_greater_or_equal_to?(other_role)
    other_role = other_role.to_s || ''

    # If the given role is not valid, raise
    raise "No such role #{other_role}" unless ROLES.include? other_role

    other_role_index = ROLES.index other_role
    role_index       = ROLES.index role

    role_index >= other_role_index
  end

  alias role_gte? role_greater_or_equal_to?

  has_many :subscriptions
  has_many :groups, through: :subscriptions

  # has_many :activities, through: :groups
end
