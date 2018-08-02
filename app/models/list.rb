class List < ApplicationRecord
  has_many :cards
  belongs_to :owner, foreign_key: 'created_by', class_name: 'User'
  has_many :list_users
  has_many :users, through: :list_users

  validates_presence_of :title, :created_by

end
