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

DB_URI = ENV['DATABASE_URL'] || AppConfig["database"]
DB = ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

## Sequel gem
# Connect to the database
# db_config = AppConfig.database
# DB = if ENV['RACK_ENV'] == 'production'
#   Sequel.connect(adapter: db_config['adapter'], user: db_config['user'], host: db_config['host'], database: db_config['name'], password: db_config['password'])
# else
#   Sequel.sqlite(db_config['name'])
# end

require './app'

run Sinatra::Application
