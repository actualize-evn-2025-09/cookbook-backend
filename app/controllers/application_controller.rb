class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  # allows the current_user method to be available outside of the controllers
  helper_method :current_user

  def current_user
    User.find_by(id: cookies.signed[:user_id])
  end

  def authenticate_user
    unless current_user
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def authenticate_admin
    unless current_user && current_user.admin
      render json: { error: "Unauthorized - must be an admin" }, status: :unauthorized
    end
  end

  def authorize_recipe_owner
    recipe = Recipe.find(params[:id])

    unless current_user.admin || recipe.user_id == current_user.id
      render json: { error: "You don't have permission to modify this recipe" }, status: :unauthorized
    end
  end
end
