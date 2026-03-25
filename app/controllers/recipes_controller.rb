class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    if params[:query].present?
      @recipes = @recipes.where("name LIKE ?", "%#{params[:query]}%")
    end

    if params[:ingredient_id].present?
      @recipes = @recipes.joins(:ingredients)
                         .where(ingredients: { id: params[:ingredient_id] })
    end

    @recipes = @recipes.page(params[:page]).per(5)
    @ingredients = Ingredient.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end