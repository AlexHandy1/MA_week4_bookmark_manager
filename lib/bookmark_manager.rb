require 'sinatra/base'
require_relative 'link'


class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    @links = Link.all
    erb :index
  end

  run! if app_file == $0
end