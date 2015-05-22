get '/links/new' do
  erb :'links/new'
end

post '/links' do
  url = params['url']
  title = params['title']
  tag = params['tags'].split(' ').map do |tag|
    Tag.first_or_create(text: tag, user_id: current_user.id)
  end
  description = params['description']
  source = params['source']
  link = Link.create(url: url, title: title, tags: tag, description: description, source: source, user_id: current_user.id)
  p link
  favourite = Favourite.first_or_create(tick: params['fav'], user_id: current_user.id, link_id: link.id)
  p favourite
  redirect to ('/')
end