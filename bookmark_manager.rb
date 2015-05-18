require 'sinatra/base'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link.rb'
require './lib/tag.rb'

DataMapper.finalize
DataMapper.auto_upgrade!


class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root,'views') }

  get '/' do
    @links = Link.all
    erb :index
  end

  post '/links' do
    url = params['url']
    title = params['title']
    tag = params['tags'].split(' ').map do |tag|
        Tag.first_or_create(text: tag)
    end
    Link.create(url: url, title: title, tags: tag)
    redirect to('/')
  end


  run! if app_file == $0
end