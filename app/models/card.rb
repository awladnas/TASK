class Card < ApplicationRecord
  belongs_to :list
  belongs_to :user, foreign_key: 'created_by', class_name: 'User'
  has_many :comments

  def card_comments
    output = []
    self.comments.root_comments.most_popular.each do |comment|
      output << comment.all_replies(comment)
    end
    output
  end
end
