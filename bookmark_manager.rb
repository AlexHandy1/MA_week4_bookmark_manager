require 'data_mapper'
require 'sinatra/base'
require 'rack-flash'

env = ENV['RACK_ENV'] ||'development'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_new_#{env}")

require_relative './lib/link.rb'
require_relative './lib/tag.rb'
require_relative './lib/user.rb'

DataMapper.finalize

DataMapper.auto_upgrade!

class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, 'views') }
  enable :sessions
  set :session_secret, 'super_secret'
  use Rack::Flash
  use Rack::MethodOverride

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
    redirect to ('/')
  end

  get '/tags/:text' do
    tag = Tag.first(text: params[:text])
    @links = tag ? tag.links : []
    erb :index
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)

    if user
      session[:user_id] = user.id
      redirect to ('/')
    else
      flash[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  delete '/sessions' do
    flash[:notice] = 'Good bye!'
    session['user_id'] = nil
    redirect to ('/')
  end

  helpers do
    def current_user
     @current_user ||= User.get(session[:user_id]) if session[:user_id]
    end
  end
end
