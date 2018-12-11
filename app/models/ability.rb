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

    #---# GENERAL

    alias_action :create, :read, :update, :destroy, to: :crud

    # Guest user
    user ||= User.new

    # Administrators can do everything
    can :manage, :all if user.of_group? :administrators

    #---# GROUPS

    # Anyone can see groups
    can :read, Group

    # Teachers can create groups
    can :create, Group if user.of_group? :teachers

    # Teachers can manage their groups
    can :manage, Group, creator: user.id if user.of_group? :teachers

    # Coordinators can manage all groups
    can :manage, Group if user.role_gte? :coordinator

    #---# SUBSCRIPTIONS

    # Can subscribe
    can :create, Subscription if user.present?

    # Can read / destroy own subscriptions
    can %i[read destroy], Subscription, user_id: user.id if user.present?

    #---# ACTIVITIES

    # Anyone can see approved activities
    can :read, Activity, &:approved?

    # Teachers can see all activities, and create more
    can %i[read create], Activity if user.of_group? :teachers

    # Teachers can manage their activities
    can :crud, Activity, creator: user.id if user.of_group? :teachers

    # Coordinators can manage all activities
    can :crud, Activity if user.role_gte? :coordinator

    # Only some users can approve activities
    # Decided by the Activity model
    cannot :approve, Activity
    can :approve, Activity do |activity|
      activity.can_be_approved_by? user
    end
  end
end
