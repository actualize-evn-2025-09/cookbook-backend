class TagsController < ApplicationController
  def index
    tags = Tag.all

    render json: tags
  end

  def create
    tag = Tag.create(name: params[:name])
    render json: tag
  end
end
