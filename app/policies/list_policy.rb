class ListPolicy < ApplicationPolicy
  attr_reader :user, :list

  def initialize(user, list)
    @user  = user
    @list = list
  end

  def index?
    if user.admin?
      list.created_by == user.id
    else
      true
    end
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

end
