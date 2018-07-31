class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, on: :create
  validates :email, presence: true, uniqueness: true

  def admin?
    role == 'admin'
  end

  def member?
    role == 'member'
  end
end
