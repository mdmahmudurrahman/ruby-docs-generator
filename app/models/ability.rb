# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    user_abilities(user) if user
  end

  def user_abilities(user)
    can :manage, Document, user: user
    can :manage, Scientist, document: { user: user }
    can :manage, MainModule, document: { user: user }
  end
end
