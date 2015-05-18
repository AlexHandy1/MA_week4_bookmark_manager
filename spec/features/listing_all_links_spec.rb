require 'capybara/rspec'
require 'link'

feature 'User browses through the links' do

  before(:each) do
    link = Link.create(title: 'Makers Academy',
                url: 'http://www.makersacademy.com/')
  end

  scenario 'when opening the home page' do
    visit '/'
    expect(page).to have_content'Makers Academy'
  end
end