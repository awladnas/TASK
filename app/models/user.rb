class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, on: :create
  validates :email, presence: true, uniqueness: true

  has_many :own_lists,foreign_key: 'created_by', class_name: 'List'

  def admin?
    role == 'admin'
  end

  def member?
    role == 'member'
  end
end
