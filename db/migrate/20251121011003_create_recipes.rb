class CreateRecipes < ActiveRecord::Migration[8.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :chef
      t.string :image_url

      t.timestamps
    end
  end
end
