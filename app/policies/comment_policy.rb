class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user  = user
    @comment = comment
  end

  def index?
    true
  end

  def create?
    user.admin? || comment.card.list.list_users.pluck(:user_id).include?(user.id)
  end

  def update?
    card.created_by == user.id
  end

  def destroy?
    card.created_by == user.id
  end

  def show?
    user.admin? || comment.card.list.list_users.pluck(:user_id).include?(user.id)
  end
end
