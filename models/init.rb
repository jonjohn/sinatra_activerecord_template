require 'rubygems'
require 'bundler/setup'

require 'yaml'
require 'active_record'

environment = (ENV['RACK_ENV'] || :development).to_s

dbconfig_file = File.join(File.dirname(File.dirname(File.expand_path(__FILE__))), 'config', 'database.yml')
dbconfig = YAML::load(File.open(dbconfig_file, 'r'))
ActiveRecord::Base.establish_connection(dbconfig[environment])



