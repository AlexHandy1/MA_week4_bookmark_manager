helpers do

  # First, instantiate the Mailgun Client with your API key
@mg_client = Mailgun::Client.new 'https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0'

# Define your message parameters
@message_params = {:from    => "Mailgun Sandbox <postmaster@sandbox29795a797e5b4c75a3a5375cb657ff3a.mailgun.org>",
                  :to      => "Alex Handy <handy437@gmail.com>",
                  :subject => 'The Ruby SDK is awesome!',
                  :text    => 'Hello, https://safe-island-1553.herokuapp.com/sessions/reset_password/'}


  # def send_simple_message
  #   RestClient.post 'https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0'\
  #     '@api.mailgun.net/v2/samples.mailgun.org/messages',
  #     from: "Mailgun Sandbox <postmaster@sandbox29795a797e5b4c75a3a5375cb657ff3a.mailgun.org>",
  #     to: "Alex Handy <handy437@gmail.com>",
  #     subject: 'Hello',
  #     text:'https://safe-island-1553.herokuapp.com/sessions/reset_password/'
  # end
end