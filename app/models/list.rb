class List < ApplicationRecord
  has_many :cards
  validates_presence_of :title, :created_by
  belongs_to :owner, foreign_key: 'created_by', class_name: 'User'
end
