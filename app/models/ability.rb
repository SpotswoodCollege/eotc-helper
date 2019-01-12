# The model for defining CanCanCan abilities.
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    alias_action :create, :read, :update, :destroy, to: :crud

    # Guest user
    user ||= User.new

    # Administrators can do everything
    if user.role? :administrator
      can :manage, :all
      return
    end

    init_standard user

    init_staff       user if user.of_group? :staff
    init_coordinator user if user.of_group? :coordinators
    init_board       user if user.of_group? :board
  end

  private

  # Standard privileges applied to all users
  def init_standard(user)
    init_standard_activities    user
    init_standard_groups        user
    init_standard_subscriptions user
    init_standard_assignments   user
  end

  # Privileges for all staff
  def init_staff(_user)
    # Can read & create activities
    can %i[read create], Activity

    # Can create groups
    can :create, Group

    # Can create assignments
    can :create, Assignment
  end

  # Privileges for EOTC Coordinators
  def init_coordinator(_user)
    can :crud, Activity
  end

  # Privileges for BoT members
  def init_board(_user)
    can %i[read create], Activity
  end

  # Methods for standard initialization

  # Activity permissions for standard users
  #
  # Can read approved activities; can manage own activities; delegate approval
  #   to Activity model
  def init_standard_activities(user)
    can :read,                   Activity, &:approved?
    can %i[read update destroy], Activity, creator: user
    cannot :approve,             Activity
    can    :approve,             Activity do |activity|
      activity.can_be_approved_by? user
    end
  end

  # Group permissions for standard users
  #
  # Can read all groups; can manage own groups
  def init_standard_groups(user)
    can :read,              Group
    can %i[update destroy], Group, creator: user
  end

  # Subscription permissions for standard users
  #
  # Can create subscriptions; can see/destroy own subscriptions
  def init_standard_subscriptions(user)
    can :create,          Subscription                   if user.present?
    can %i[read destroy], Subscription, user_id: user.id if user.present?
  end

  # Assignment permissions for standard users
  #
  # Can read assignments when their activities are also visible;
  # can read/destroy assignments where user created their activities/groups
  def init_standard_assignments(user)
    cannot %i[read destroy], Assignment
    can    :read, Assignment do |assignment|
      can?(:read, assignment.activity) || assignment.owned_by?(user)
    end
    can :destroy, Assignment do |assignment|
      assignment.inspect
      assignment.owned_by? user
    end
  end
end
