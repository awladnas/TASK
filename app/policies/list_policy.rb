class ListPolicy < ApplicationPolicy
  attr_reader :user, :list

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        user.own_lists
      else
        user.lists
      end
    end
  end

  def initialize(user, list)
    @user  = user
    @list = list
  end

  # def index?
  #   if user.admin?
  #     list.created_by == user.id
  #   else
  #     true
  #   end
  # end

  def index?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? && list.created_by == user.id
  end

  def destroy?
    user.admin? && list.created_by == user.id
  end

  def assign_member?
    user.admin? && list.created_by == user.id
  end

  def unassign_member?
    user.admin? && list.created_by == user.id
  end

  def show?
    list.created_by == user.id || list.list_users.pluck(:member_id).include?(user.id)
  end
end
