require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require_relative 'link'

DataMapper.finalize
DataMapper.auto_upgrade!