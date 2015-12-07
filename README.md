# rake_for_sinatra
Because being lazy is awesome!

1. Build a Gemfile. Include the `rake` and `sinatra-activerecord` gems in your `Gemfile`. Then, `bundle`.
2. Let's create a simple app. This can work for any application, though. Create an `app.rb` with:
    * `ActiveRecord::Base.establish_connection()`
3. Let's build a `config.ru` to `require('./app')` & `run Sinatra::Application`
