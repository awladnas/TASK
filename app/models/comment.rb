class Comment < ApplicationRecord
  belongs_to :card
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  scope :root_comments, -> {where("parent_id IS ?", nil)}
end
