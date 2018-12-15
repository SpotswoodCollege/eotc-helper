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
    init_staff    user if user.of_group? :staff
  end

  private

  # Standard privileges applied to all users
  def init_standard(user)
    # Can read approved activities; can manage own activities; delegate approval
    #   to Activity model
    can :read,                  Activity, &:approved?
    can %i[read update delete], Activity, creator: user
    cannot :approve,            Activity
    can    :approve,            Activity do |activity|
      activity.can_be_approved_by? user
    end

    # Can read all groups; can manage own groups
    can :read,                  Group
    can %i[read update delete], Group, creator: user

    # Can create subscriptions; can see/delete own subscriptions
    can :create,         Subscription                   if user.present?
    can %i[read delete], Subscription, user_id: user.id if user.present?

    # Can read assignments when their activities are also visible
    cannot :read, Assignment
    can    :read, Assignment do |assignment|
      can? :read, assignment.activity
    end
  end

  def init_staff(_user)
    # Can read & create activities
    can %i[read create], Activity

    # Can create groups
    can :create, Group

    # Can create assignments; can delete assignments where activity/group is
    #   also deletable
    can :create,    Assignment
    cannot :delete, Assignment
    can :delete,    Assignment do |assignment|
      can?(:delete, assignment.group) || can?(:delete, assignment.activity)
    end
  end

  # TODO: Add all important roles etc.
  #       Awaiting @spottyboy
end
