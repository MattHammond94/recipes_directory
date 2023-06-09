require 'recipe_repository'

describe RecipeRepository do
  def reset_recipes_table
    seed_sql = File.read('spec/recipe_test_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_recipes_table
  end

  it 'Should return an array of all recipe objects when all is called' do
    repo = RecipeRepository.new
    recipes = repo.all
    expect(recipes.first.name).to eq 'Baked Ziti'
    expect(recipes.last.name).to eq 'Triffle'
    expect(recipes[2].average_cooking_time).to eq '10 minutes'
  end

  it 'Should return a single recipe object corresponding to id given as arg' do
    repo = RecipeRepository.new
    recipe = repo.find(4)
    expect(recipe.id).to eq '4'
    expect(recipe.name).to eq 'Beans on toast'
  end

  it 'Further find test - should return same result for different id value passed' do
    repo = RecipeRepository.new
    recipe = repo.find(3)
    expect(recipe.name).to eq 'Nachos'
  end
end