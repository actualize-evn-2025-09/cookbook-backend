class Tag < ApplicationRecord
  has_many :recipe_tags
  has_many :recipes, through: :recipe_tags


  # def recipes
  #   recipe_tags.map do |recipe_tag|
  #     recipe_tag.recipe
  #   end
  # end
end
