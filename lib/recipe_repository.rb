require_relative './recipe'

class RecipeRepository

  def all
    selected = DatabaseConnection.exec_params('SELECT * FROM recipes;', [])

    recipes = []
    selected.each do |item|
      recipe = Recipe.new
      recipe.id = item['id']
      recipe.name = item['name']
      recipe.average_cooking_time = item['average_cooking_time']
      recipe.rating = item['rating']

      recipes << recipe
    end
    recipes
  end
end