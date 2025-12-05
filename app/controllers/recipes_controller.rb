class RecipesController < ApplicationController
  # callback

  # run the authenticate_user for every action exctpe the index action
  before_action :authenticate_user, except: [:index, :show]
  # authenticate user will run for create, update, and destroy
  # authenticate admin will run for update and destroy
  before_action :authenticate_admin, only: [:update, :destroy]
  # anyone can see the data - index and show
  # only logged in users can create data
  # only admins can update or destroy

  # run the authenticate_user before only the show action
  # before_action :authenticate_user, only: [:show]

  def index
    recipes = Recipe.all.order(:id)
    render json: recipes
  end

  def create
    recipe = Recipe.new(
      title: params[:title],
      chef: params[:chef],
      image_url: params[:image_url],
      user_id: current_user.id
    )
    if recipe.save
      render json: recipe
    else
      render json: { errors: recipe.errors.full_messages }, status: :bad_request
    end
  end

  # if this recipe is the user's recipe or they're an admin then they can edit 
  # if this recipe is not their recipe and they're not an admin then they can't edit the recipe

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
