class CardPolicy < ApplicationPolicy
  attr_reader :user, :card, :list

  class Scope < Struct.new(:user, :scope)
    def resolve
      user.cards
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
    true || list.created_by == user.id || list.users.pluck(:user_id).include?(user.id)
  end

  def update?
    card.created_by == user.id
  end

  def destroy?
    (user.admin? && list.created_by == user.id) || card.created_by == user.id
  end

  def assign_member?
    user.admin? && list.created_by == user.id
  end

  def unassign_member?
    user.admin? && list.created_by == user.id
  end

  def show?
    true || list.created_by == user.id || list.list_users.pluck(:member_id).include?(user.id)
  end
end
