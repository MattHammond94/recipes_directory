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

  def find(id)
    sql = 'SELECT id, name, average_cooking_time, rating FROM recipes WHERE id = $1;'
    params = [id]
    selected = DatabaseConnection.exec_params(sql, params)
    
    recipe = selected[0]
    item = Recipe.new
    item.id = recipe['id']
    item.name = recipe['name']
    item.average_cooking_time = recipe['average_cooking_time']
    item.rating = recipe['rating']
    item
  end
end