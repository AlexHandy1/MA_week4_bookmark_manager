post '/links' do

  url = params['url']
  title = params['title']
  tag = params['tags'].split(' ').map do |tag|
    Tag.first_or_create(text: tag)
  end
  description = params['description']
  Link.create(url: url, title: title, tags: tag, description: description)
  redirect to ('/')
end