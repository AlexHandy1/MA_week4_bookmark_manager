env = ENV['RACK_ENV'] ||'development'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_new_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!