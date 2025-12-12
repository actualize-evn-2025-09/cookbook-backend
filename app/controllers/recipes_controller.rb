class RecipesController < ApplicationController
  # callback

  # run the authenticate_user for every action exctpe the index action
  before_action :authenticate_user, except: [:index, :show]
  # authenticate user will run for create, update, and destroy
  # authenticate admin will run for update and destroy
  before_action :authorize_recipe_owner, only: [:update, :destroy]
  # anyone can see the data - index and show
  # only logged in users can create data
  # only admins can update or destroy

  # run the authenticate_user before only the show action
  # before_action :authenticate_user, only: [:show]

  def index
    @recipes = Recipe.all.order(:id)

    if params[:tag] && params[:tag] != ""
      tag = Tag.find_by(name: params[:tag])
      @recipes = tag.recipes
    end

    render :index
  end

  def create
    @recipe = Recipe.new(
      title: params[:title],
      chef: params[:chef],
      image_url: params[:image_url],
      user_id: current_user.id
    )

    if @recipe.save

      if params[:tag_id] && params[:tag_id] != ""
        RecipeTag.create(recipe_id: @recipe.id, tag_id: params[:tag_id])
      end

      render :show
    else
      render json: { errors: @recipe.errors.full_messages }, status: :bad_request
    end
  end

  # if this recipe is the user's recipe or they're an admin then they can edit 
  # if this recipe is not their recipe and they're not an admin then they can't edit the recipe

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render :show
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.title = params[:title] || @recipe.title
    @recipe.chef = params[:chef] || @recipe.chef
    @recipe.image_url = params[:image_url] || @recipe.image_url

    if @recipe.save
      render :show
    else
      render json: { errors: @recipe.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.destroy
    render json: { message: "Recipe successfully destroyed!" }
  end
end
