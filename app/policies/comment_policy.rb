class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user  = user
    @comment = comment
  end

  def index?
    user.admin? || list_users.pluck(:user_id).include?(user.id)
  end

  def create?
    user.admin? || list_users.pluck(:user_id).include?(user.id)
  end

  def update?
    (user.admin?  && list_owner == user.id) || comment.created_by == user.id
  end

  def destroy?
    (user.admin?  && list_owner == user.id) ||  comment.created_by == user.id
  end

  def show?
    user.admin? || list_users.include?(user.id)
  end

  # helper methods

  def list_users
    load_list.list_users.pluck(:user_id)
  end

  def list_owner
    load_list.created_by
  end

  def load_list
    card = comment.card || Card.find_by(id: comment.card_id)
    card.list
  end
end
