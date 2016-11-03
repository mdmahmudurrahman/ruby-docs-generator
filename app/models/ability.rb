# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    user_abilities(user) if user
  end

  def user_abilities(user)
    can :manage, Document, user: user
    can :manage, Scientist, get_document(user)
    can :manage, MainModule, get_document(user)
    can :manage, SubModule, get_main_module(user)
    can :manage, Topic, get_sub_module(user)
  end

  def get_document(user)
    { document: { user: user } }
  end

  def get_main_module(user)
    { main_module: get_document(user) }
  end

  def get_sub_module(user)
    { sub_module: get_main_module(user) }
  end
end
