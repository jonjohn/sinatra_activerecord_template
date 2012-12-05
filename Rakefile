require 'rubygems'
require 'bundler/setup'

require 'active_record'
require 'yaml'
require 'logger'


task :environment do
  require_relative 'models/init.rb'
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end

namespace :db do
  desc "Run pending migrations"
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate("db/migrate", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    Rake::Task["db:schema:dump"].invoke
  end
  desc "Roll database schema back one migration"
  task :rollback => :environment do
    ActiveRecord::Migrator.rollback("db/migrate", ENV["STEP"] ? ENV["STEP"].to_i : 1)
    Rake::Task["db:schema:dump"].invoke
  end

  namespace :schema do
    desc "Create db/schema.rb that can be loaded to any db supported by AR"
    task :dump => :environment do
      require 'active_record/schema_dumper'
      File.open(ENV['SCHEMA'] || "db/schema.rb", "w") do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end

    desc "Load schema.rb into database"
    task :load => :environment do
      file = ENV["SCHEMA"] || "db/schema.rb"
      load(file)
    end
  end
end

