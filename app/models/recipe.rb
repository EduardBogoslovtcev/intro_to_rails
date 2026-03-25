class Recipe < ApplicationRecord
  has_many :recipe_users
  has_many :users, through: :recipe_users

  has_many :ingredient_recipes
  has_many :ingredients, through: :ingredient_recipes

  validates :name, presence: true
  validates :category, presence: true
end