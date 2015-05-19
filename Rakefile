# require 'rspec/core/rake_task'
# require 'rubocop/rake_task'
require 'data_mapper'
#require 'data_mapper_setup' #where is this? #what do?

# RuboCop::RakeTask.new :cop
# RSpec::Core::RakeTask.new :spec

# task default: [:cop, :spec]

#Recommended resolution

# begin
#   require "rspec/core/rake_task"
#   desc "Run all examples"
#   RSpec::Core::RakeTask.new(:spec) do |t|
#     t.rspec_opts = %w[--color]
#     t.pattern = 'spec/**/*_spec.rb'
#   end
# rescue LoadError
# end

task :auto_upgrade do

  DataMapper.auto_upgrade!
  puts 'Auto-upgrade complete (no data loss)'
end

task :auto_migrate do
  DataMapper.auto_migrate!
  puts 'Auto-migrate complete (data could have been lost)'
end