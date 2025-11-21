class RecipesController < ApplicationController
  def index
    recipes = Recipe.all.order(:id)
    render json: recipes
  end

  def create
    recipe = Recipe.new(
      title: params[:title],
      chef: params[:chef],
      image_url: params[:image_url],
    )
    if recipe.save
      render json: recipe
    else
      render json: { errors: recipe.errors.full_messages }, status: :bad_request
    end
  end

  def show
    recipe = Recipe.find_by(id: params[:id])
    render json: recipe
  end

  def update
    recipe = Recipe.find_by(id: params[:id])
    recipe.title = params[:title] || recipe.title
    recipe.chef = params[:chef] || recipe.chef
    recipe.image_url = params[:image_url] || recipe.image_url

    if recipe.save
      render json: recipe
    else
      render json: { errors: recipe.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    recipe = Recipe.find_by(id: params[:id])
    recipe.destroy
    render json: { message: "Recipe successfully destroyed!" }
  end
end
