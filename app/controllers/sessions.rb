require 'rest-client'

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
 @user =  User.first(email: params[:email])

 @user.password_token = (1..50).map{('A'..'Z').to_a.sample}.join

 @user.password_token_timestamp = Time.now
 @user.save

 session[:user_id] = @user.id
 flash[:notice] = "Thanks, you will receive an email shortly"
 # Send your message through the client
 send_simple_message
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
  @user.password_token = nil
  @user.password_token_timestamp = nil
  @user.save
  redirect to('/')
end



