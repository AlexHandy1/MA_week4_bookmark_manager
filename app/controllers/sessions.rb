get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  email, password = params["email"], params["password"]
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
  flash[:notice] = 'Goodbye'
  session[:user_id] = nil
  redirect to ('/')
end

get '/sessions/passwordlost' do
  erb :'sessions/lost'
end

post '/sessions/passwordlost' do
 user =  User.first(email: params[:email])

 user.password_token = (1..50).map{('A'..'Z').to_a.sample}.join
 p user.password_token

 user.password_token_timestamp = Time.now
 user.save

 session[:user_id] = user.id
 flash[:notice] = "Thanks, you will receive an email shortly"
 # Send your message through the client
 @mg_client.send_message "https://safe-island-1553.herokuapp.com", @message_params
 erb :'sessions/lost'
end

get '/sessions/reset_password/:token' do
  @token = params[:token]
  erb :'sessions/reset'
end

post '/sessions/reset_password' do
  @token = params[:token]
  @user = User.first(password_token: @token)
  @user.password = params[:password]
  @user.password_confirmation = params[:password_confirmation]
  @user.save
  redirect to('/')
end



