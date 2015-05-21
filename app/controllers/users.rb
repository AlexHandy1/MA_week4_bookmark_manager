get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.create(email: params[:email],
                      password: params[:password],
                      password_confirmation: params[:password_confirmation])

  if @user.save
    session[:user_id] = @user.id
    redirect to ('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :'users/new'
  end
end

get '/users/profile' do
  @user_id = session[:user_id]
  @links = Link.all
  @tags = Tag.all
  @user = User.get(@user_id)
  erb :'users/profile'
end