require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/recipes.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Recipe.count, data.length
  end

  test "show" do
    post "/users.json", params: { name: "Test", email: "test@test.com", password: "password", password_confirmation: "password" }
    post "/sessions.json", params: { email: "test@test.com", password: "password" }

    get "/recipes/#{Recipe.first.id}.json"
    assert_response 200
  end

  test "create" do
    assert_difference "Recipe.count", 1 do
      post "/users.json", params: { name: "Test", email: "test@test.com", password: "password", password_confirmation: "password" }
      post "/sessions.json", params: { email: "test@test.com", password: "password" }

      post "/recipes.json", params: { title: "Cake", chef: "Jay", image_url: "test.jpg", prep_time: 10, ingredients: "Batter", directions: "Bake" }
      assert_response 200
    end
  end

  test "update" do
    post "/users.json", params: { name: "Test", email: "test@test.com", password: "password", password_confirmation: "password" }
    post "/sessions.json", params: { email: "test@test.com", password: "password" }

    recipe = Recipe.first
    patch "/recipes/#{recipe.id}.json", params: { title: "Updated Dish" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated Dish", data["title"]
  end

  test "destroy" do
    assert_difference "Recipe.count", -1 do
      post "/users.json", params: { name: "Test", email: "test@test.com", password: "password", password_confirmation: "password" }
      post "/sessions.json", params: { email: "test@test.com", password: "password" }

      delete "/recipes/#{Recipe.first.id}.json"
      assert_response 200
    end
  end
end
