class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.page(params[:page]).per(5)
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end
end