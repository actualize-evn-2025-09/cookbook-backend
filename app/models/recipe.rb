class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags

  # def tags
  #   recipe_tags.map do |recipe_tag|
  #     recipe_tag.tag
  #   end
  # end
end
