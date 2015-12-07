## Rake for Sinatra
A guide to using Rake tasks with Sinatra.

#### Why Rake?

* Rake allows you to create tasks in Ruby.
* Such as creating a database, adding some tables, and dropping it.
* You can also use rake to do many other things.

#### Getting Started

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
9. It this ran correctly, we can now automatically create **all** of our databases! Let's do that by running `bundle exec rake db:create`.
10. Open `psql` and `\connect` to the database you have specified in your `app.rb`.
11. List out relations with `\dt`. What do you see? Nothing?
12. Let's create some relations! We'll build our first table: `bundle exec rake db:create_migration NAME=create_accounts`
13. We're creating a **migration** and giving it a *task name*. The migration will be found in `./db/migrate`.
14. Let's open our newly created migration file. It should contain a `change` method. Notice the use of Ruby? Let's add a column to our table:
   ```ruby
   class CreateAccounts < ActiveRecord::Migration
      def change
        create_table :accounts do |t|
          t.string :name
          t.text :password_hash
        end
      end
   end
   ```
15. Our `:primary_key` will automatically be defined for us, by the way!
16. Now, let's actually create our database tables... `bundle exec rake db:migrate`
17. You should notice some awesomeness: you'll be alerted that things went well with how long they took!
18. Now, let's **drop** our entire database from scratch and start over. Run `bundle exec rack db:drop`. If you're told other sessions exist, you should exit your database's terminal (such as `psql`).
19. For practice, let us create a database and tables again. We don't need to re-create our migrations since they're already done for us.
20. `bundle exec rake db:create` will create our database for us.
21. `bundle exec rake db:migrate` will create our tables for us.
22. And we can start from scratch with `bundle exec rake db:drop`

#### database.yml Example with Postgresql

```yaml

development:
  adapter: postgresql
  encoding: unicode
  database: rake_101_dev
  pool: 5
  username: codeforcoffee
  password:

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: postgresql
  encoding: unicode
  database: rake_101_test
  pool: 5
  username: codeforcoffee
  password:

production:
  adapter: postgresql
  encoding: unicode
  database: rake_101
  pool: 5
  username: codeforcoffee
  password:

```


#### Migration Types

All ActiveRecord databases can use these **types** with ActiveRecord migrations.

```ruby
:binary
:boolean
:date
:datetime
:decimal
:float
:integer
:primary_key
:references
:string
:text
:time
:timestamp
```

Postgresql can support the following additional types:

```ruby
:hstore
:json
:array
:cidr_address
:ip_address
:mac_address
```
