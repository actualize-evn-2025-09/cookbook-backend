# Clear existing data
Recipe.destroy_all
User.destroy_all

# --- Users ---
puts "Creating users..."

admin = User.create!(
  name: "Leon Shimizu",
  email: "leon@test.com",
  password: "password",
  admin: true
)

user1 = User.create!(
  name: "Maria Santos",
  email: "maria@test.com",
  password: "password",
  admin: false
)

user2 = User.create!(
  name: "Tony Ramirez",
  email: "tony@test.com",
  password: "password",
  admin: false
)

puts "Users created!"


# --- Recipes ---
puts "Creating recipes..."

recipes = [
  { title: "Chamorro Red Rice", chef: "Chef Juan", img: 1 },
  { title: "Garlic Butter Shrimp", chef: "Chef Maria", img: 2 },
  { title: "Beef Tinaktak", chef: "Chef Tony", img: 3 },
  { title: "Chicken Kelaguen", chef: "Chef Lina", img: 4 },
  { title: "BBQ Short Ribs", chef: "Chef Ray", img: 5 },
  { title: "Lumpia", chef: "Chef Ann", img: 6 },
  { title: "Kadon Pika", chef: "Chef Nelson", img: 7 },
  { title: "Pancit Bihon", chef: "Chef May", img: 8 },
  { title: "Fried Parrotfish", chef: "Chef Sam", img: 9 }
]

recipes.each_with_index do |recipe_data, index|
  Recipe.create!(
    title: recipe_data[:title],
    chef: recipe_data[:chef],
    image_url: "https://picsum.photos/640/480?random=#{recipe_data[:img]}",
    user_id: [admin.id, user1.id, user2.id].sample # randomly assign an owner
  )
end

puts "Recipes created!"

puts "Seeding complete!"
