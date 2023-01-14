class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_uniqueness_of :email

  def projects_created
    projects
  end

  def task_assigned
    tasks
  end

end
