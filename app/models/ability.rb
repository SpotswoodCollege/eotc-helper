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

    # Guest user
    user ||= User.new

    # Administrators can do everything
    can :manage, :all if user.role_gte? :administrator

    #---# GROUPS

    # Anyone can see groups
    can :read, Group

    # Teachers can create groups
    can :create, Group if user.role_gte? :teacher

    # Teachers can manage their groups
    can :manage, Group, creator: user.id if user.role? :teacher

    # Coordinators can manage all groups
    can :manage, Group if user.role_gte? :coordinator

    #---# SUBSCRIPTIONS

    # Can subscribe
    can :create, Subscription if user.present?

    # Can read own subscriptions
    can %i[read destroy], Subscription, user_id: user.id if user.present?
  end
end
