# Rake for Sinatra
A guide to using Rake tasks with Sinatra.

1. Build a Gemfile. Include the `rake` and `sinatra-activerecord` gems in your `Gemfile`. Then, `bundle`.
2. Let's create a simple app. This can work for any application, though. Create an `app.rb` with:
    * `ActiveRecord::Base.establish_connection()`
3. Let's build a `config.ru` to `require('./app')` & `run Sinatra::Application`
4. Create a new file: `Rakefile`. This is where we are going to store our tasks.
5. Create a folder called `config` and create `config/database.yml` too store your database information. A template is provided below to get you started.
6. Let's describe what a **task** is. What do you think it is? Is a task something you need to knock out?
7. In your `Rakefile`, we need to create a task to `load_config`...
    ```ruby
    require "sinatra/activerecord/rake"
    
    namespace :db do
      task :load_config do
        require "./app"
      end
    end
    ```
8. Let's test and see if this works in our **Terminal**: `bundle exec rake -T`

#### database.yml Example

```yaml
# SQLite version 3.x
#   gem install sqlite3
#
#   Ensure the SQLite 3 gem is defined in your Gemfile
#   gem 'sqlite3'
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000

production:
  adapter: postgresql
  encoding: unicode
  database: database_name
  pool: 5
  username: your_mac_username
  password:
```