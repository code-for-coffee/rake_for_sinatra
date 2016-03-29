require "sinatra/activerecord/rake"
require 'yaml'
require 'ostruct'
require 'bundler'
Bundler.require

Dotenv.load

ENV["RACK_ENV"] ||= "development"

full_config = YAML.load_file('./config/database.yml') || {}
env_config  = full_config[ENV['RACK_ENV']] || {}
AppConfig    = OpenStruct.new(env_config)

namespace :db do
  desc "Create database based on a DATABASE_URL"
  task :create do
    begin
      case AppConfig['adapter']
      when /sqlite/
        if File.exist?(AppConfig['database'])
          $stderr.puts "#{AppConfig['database']} already exists"
        else
          # Create the SQLite database; just connecting is enough to create it.
          ActiveRecord::Base.establish_connection AppConfig.symbolize_keys
          ActiveRecord::Base.connection
          $stderr.puts "#{AppConfig['database']} created"
        end

      when /postgresql/
        encoding = AppConfig['encoding'] || ENV['CHARSET'] || 'utf8'
        ActiveRecord::Base.establish_connection AppConfig.symbolize_keys
        $stderr.puts "#{AppConfig['database']} created"
      end
    end
  end
end
