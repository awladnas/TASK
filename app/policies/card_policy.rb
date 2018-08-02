class CardPolicy < ApplicationPolicy
  attr_reader :user, :card, :list

  class Scope < Struct.new(:user, :scope)
    def resolve
      user.admin? ? scope.all : user.cards
    end
  end

  def initialize(user, card)
    @user  = user
    @card = card
  end


  def index?
    user.cards
  end

  def create?
    user.admin? || card.list.users.pluck(:user_id).include?(user.id)
  end

  def update?
    card.created_by == user.id
  end

  def destroy?
    card.created_by == user.id
  end

  def show?
    user.admin? || card.list.list_users.pluck(:member_id).include?(user.id)
  end
end
