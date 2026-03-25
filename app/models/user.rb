class User < ApplicationRecord
  has_many :recipe_users
  has_many :recipes, through: :recipe_users

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end