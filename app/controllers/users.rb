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
  #Show the link ids attached to favourite for @user_id and if favourite.tick == "favourite"
    #get the links added by a user id
    #get link title for corresponding link id
    #get only the link ids where favourite.tick == "favourite"
    #in SQL >> SELECT * FROM "users" WHERE "id" IN (SELECT "title" FROM "links" WHERE "user_id" = 1)
  erb :'users/profile'
end