require 'net/http'
require 'json'
require 'faker'

# Data sources:
# 1. Users: Faker
# 2. Recipes: https://www.themealdb.com/api.php
# 3. Ingredients: https://www.fruityvice.com/#3

puts "Clearing database..."
RecipeUser.destroy_all
IngredientRecipe.destroy_all
User.destroy_all
Recipe.destroy_all
Ingredient.destroy_all


# CONFIG (controls total rows)
USER_COUNT = 20
RECIPE_COUNT = 20
INGREDIENT_COUNT = 10
RECIPE_USER_COUNT = 75
INGREDIENT_RECIPE_COUNT = 75

# USERS (Faker)
puts "Creating users..."
USER_COUNT.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email
  )
end


# RECIPES (API)
puts "Fetching recipes..."

url = URI("https://www.themealdb.com/api/json/v1/1/search.php?s=chicken")
response = Net::HTTP.get(url)
data = JSON.parse(response)

recipes = []

data["meals"].first(RECIPE_COUNT).each do |meal|
  recipes << Recipe.create!(
    name: meal["strMeal"],
    category: meal["strCategory"],
    instructions: meal["strInstructions"]
  )
end

# INGREDIENTS (API)
puts "Fetching ingredients..."

fruits = [
  "apple", "banana", "orange", "mango", "pear",
  "pineapple", "grape", "kiwi", "lemon", "lime"
]

ingredients = []

fruits.first(INGREDIENT_COUNT).each do |fruit|
  url = URI("https://www.fruityvice.com/api/fruit/#{fruit}")
  response = Net::HTTP.get(url)
  data = JSON.parse(response)

  ingredients << Ingredient.create!(
    name: data["name"],
    calories: data["nutritions"]["calories"]
  )
end

users = User.all

# RECIPE ↔ USERS (many-to-many)
puts "Creating RecipeUser associations..."

RECIPE_USER_COUNT.times do
  RecipeUser.create!(
    user: users.sample,
    recipe: recipes.sample
  )
end

# RECIPE ↔ INGREDIENTS (many-to-many)
puts "Creating IngredientRecipe associations..."

INGREDIENT_RECIPE_COUNT.times do
  IngredientRecipe.create!(
    ingredient: ingredients.sample,
    recipe: recipes.sample
  )
end

puts "Done seeding!"

# DEBUG COUNT
total =
  User.count +
  Recipe.count +
  Ingredient.count +
  RecipeUser.count +
  IngredientRecipe.count

puts "TOTAL ROWS: #{total}"