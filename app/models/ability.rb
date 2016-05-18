class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Todos
    can :read, Todo
    can :manage, Todo, user_id: user.id if user.persisted?

    # Users
    can :create, User unless user.persisted?
    can :read, User
    can :update, user
  end
end
