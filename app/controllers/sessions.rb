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
 session[:user_id] = user.id
 flash[:notice] = "Thanks, you will receive an email shortly"
 erb :'sessions/lost'
end