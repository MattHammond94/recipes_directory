# Recipes Model and Repository Classes Design Recipe

## 1. Design and Create the table

User Stories:
> As a food lover,
> So I can stay organised and decide what to cook,
> I'd like to keep a list of all my recipes with their (names.)

> As a food lover,
> So I can stay organised and decide what to cook,
> I'd like to keep the (average cooking time (in minutes)) for each recipe.

> As a food lover,
> So I can stay organised and decide what to cook,
> I'd like to give ((a rating) to each of the recipes (from 1 to 5).)

Table design:
Table: Recipes

Columns:
id | name/dish | average_cooking_time | rating 
 
id: SERIAL 
name: text
average_cooking_time: text (number followed by 'minutes' as a string)
rating: int

```sql 
CREATE TABLE recipes (
  id SERIAL PRIMARY KEY,
  name text,
  average_cooking_time text,
  rating int
);
```

Create table:
psql -h 127.0.0.1 recipes_directory < recipes_setup.sql


## 2. Create the SQL seeds
```sql
-- file: spec/recipe_seeds.sql)

TRUNCATE TABLE recipes RESTART IDENTITY;

INSERT INTO recipes(name, average_cooking_time, rating) VALUES('Baked Ziti', '25 minutes', 5);
INSERT INTO recipes(name, average_cooking_time, rating) VALUES('Pasta A la MattyBoi', '10 minutes', 5);
INSERT INTO recipes(name, average_cooking_time, rating) VALUES('Nachos', '10 minutes', 3);
INSERT INTO recipes(name, average_cooking_time, rating) VALUES('Beans on toast', '5 minutes', 2);
INSERT INTO recipes(name, average_cooking_time, rating) VALUES('Fry up', '15 minutes', 4);


psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# Table name: recipes

```ruby
# Model class
# (in lib/recipe.rb)

class Recipe
  
end

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository
  
end
```

## 4. Implement the Model class

``` ruby

# Model class
# (in lib/recipe.rb)

class Recipe
  attr_accessor :id, :name, :average_cooking_time, :rating
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,

```

## 5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

```ruby
# EXAMPLE
# Table name: recipes

# Repository class
# (in lib/recipe_repository.rb)

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM recipes;

    # Returns an array of Book objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT name, average_cooking_time, rating FROM recipes WHERE id = $1;
    # params = [id]

    # Returns a single recipe object.
  end

  def create(book)
    # adds a book object to the database
    # 'INSERT INTO recipes(name, average_cooking_time, rating) VALUES('Shrimo Toast', '5 minutes' 3);'
  end
end
```

## 6. Write Test Examples
These examples will later be encoded as RSpec tests.

```ruby

# EXAMPLES

# 1
# Get all books

repo = RecipeRepository.new

recipes = repo.all

recipes.length # =>  Amount of recipes in DB as an int

recipes[0].id # =>  1
recipes[0].name # =>  'Baked Ziti'
recipes[0].average_cooking_time # =>  '25 minutes'
recipes[0].rating # => 4

recipes[1].id # =>  2
recipes[1].name # =>  ''
recipes[1]. # =>  ''

# 2
# Get a single student

repo = RecipeRepository.new

recipe = repo.find(1)

recipe.id # =>  1
recipe.title # =>  ''
recipe.author_name # =>  ''

```

## 7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

```ruby
# EXAMPLE

# file: spec/recipe_repository_spec.rb

 def reset_recipes_table
    seed_sql = File.read('spec/recipe_test_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_recipes_table
  end
end
```

## 8. Test-drive and implement the Repository class behaviour
_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._