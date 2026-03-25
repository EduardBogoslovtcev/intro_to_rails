class Ingredient < ApplicationRecord
  has_many :ingredient_recipes
  has_many :recipes, through: :ingredient_recipes

  validates :name, presence: true, uniqueness: true
  validates :calories, numericality: { greater_than_or_equal_to: 0 }
end