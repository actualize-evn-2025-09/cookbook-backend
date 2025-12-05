class AddUserIdToRecipes < ActiveRecord::Migration[8.1]
  def change
    add_column :recipes, :user_id, :integer
  end
end
