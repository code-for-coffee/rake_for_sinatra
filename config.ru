require 'yaml'
require 'ostruct'
require 'bundler'
Bundler.require

Dotenv.load

ENV["RACK_ENV"] ||= "development"

full_config = YAML.load_file('./config/database.yml') || {}
env_config  = full_config[ENV['RACK_ENV']] || {}
AppConfig    = OpenStruct.new(env_config)

## ActiveRecord

if ENV['DATABASE_URL']
  Bundler.require(:production)
  DB = ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  Bundler.require(:development)
  DB = ActiveRecord::Base.establish_connection(
    :adapter => AppConfig["adapter"],
    :database => AppConfig["database"]
  )
end

## Sequel gem
# heroku provides a ENV var called ENV['DATABASE_URL']
# if ENV['DATABASE_URL']
# Bundler.require(:default, :production)
# DB = Sequel.connect(ENV['DATABASE_URL'])
# else
# Bundler.require(:default, :development)
# DB = Sequel.sqlite('development.sqlite')
# end

require './app'

run Sinatra::Application
