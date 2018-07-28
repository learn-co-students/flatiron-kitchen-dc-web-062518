require 'pry'
class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update]

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    # binding.pry
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      params[:recipe][:ingredient_ids].each do |id|
        if id != ""
          @recipe.ingredients << Ingredient.find(id)
        end
      end
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
  end

  def update
    # binding.pry
    if @recipe.update(recipe_params)
      @recipe.ingredients.clear
      params[:recipe][:ingredient_ids].each do |id|
        if id != ""
          @recipe.ingredients << Ingredient.find(id)
        end
      end
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end


private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name)
  end
end
