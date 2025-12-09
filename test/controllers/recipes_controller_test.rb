require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    post "/users.json", params: { name: "Test", email: "test@test.com", password: "password", password_confirmation: "password", admin: true }
    post "/sessions.json", params: { email: "test@test.com", password: "password" }
  end

  test "index" do
    get "/recipes.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Recipe.count, data.length
  end

  test "show" do
    get "/recipes/#{Recipe.first.id}.json"
    assert_response 200
  end

  test "create" do
    assert_difference "Recipe.count", 1 do
      post "/recipes.json", params: { title: "Cake", chef: "Jay", image_url: "test.jpg", prep_time: 10, ingredients: "Batter", directions: "Bake" }
      assert_response 200
    end

    # test sad path - if someone isn't signed in
    delete "/sessions.json"
    post "/recipes.json", params: { title: "Test", chef: "Test Chef", image_url: "test.jpg" }
    assert_response 401
  end

  test "update" do
    recipe = Recipe.first
    patch "/recipes/#{recipe.id}.json", params: { title: "Updated Dish" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated Dish", data["title"]

    # test sad path - if someone isn't signed in
    delete "/sessions.json"
    patch "/recipes/#{recipe.id}", params: { title: "Something Else" }
    assert_response 401
  end

  test "destroy" do
    assert_difference "Recipe.count", -1 do
      delete "/recipes/#{Recipe.first.id}.json"
      assert_response 200
    end

    # test sad path - if someone isn't signed in
    delete "/sessions.json"
    delete "/recipes/#{Recipe.first.id}"
    assert_response 401
  end
end
