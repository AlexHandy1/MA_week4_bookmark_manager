require 'sinatra/base'
require_relative 'link'
require_relative 'server'


class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    @links = Link.all
    erb :index
  end

  post '/links' do
    url = params['url']
    title = params['title']
    Link.create(url: url, title: title)
    redirect to('/')
  end

  run! if app_file == $0
end