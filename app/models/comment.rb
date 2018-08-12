class Comment < ApplicationRecord
  belongs_to :card
  belongs_to :parent, class_name: 'Comment', optional: true,  counter_cache: :replies_count
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  scope :most_popular, -> { order('replies_count DESC') }
  scope :root_comments, -> {where("parent_id IS ?", nil)}


  def all_replies(comment)
    replies = []
    unless comment.replies.blank?
      comment.replies.each do |rep|
        replies << all_replies(rep)
      end
    end
    {id: comment.id, content: comment.content, replies: replies}
  end
end
