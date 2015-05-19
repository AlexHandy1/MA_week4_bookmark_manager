require 'capybara/rspec'
require 'spec_helper'

feature 'User browses through the links' do

  before(:each) do
    Link.create(title: 'Makers Academy',
                url: 'http://www.makersacademy.com/',
                tags: [Tag.first_or_create(text: 'education')])
    Link.create(title: 'Hi',
                url: 'http://boo.com',
                tags: [Tag.first_or_create(text: 'whatever')])
    Link.create(title: 'Yo',
                url: 'http://yo.com',
                tags: [Tag.first_or_create(text: 'whatever')])
  end

  scenario 'when opening the home page' do
    visit '/'
    expect(page).to have_content'Makers Academy'
  end

  #why failing - implementation works
  scenario 'and can see a list of available tags' do
    visit '/'
    expect(page).to have_content('whatever')
  end

  scenario 'and can search filtered links' do
    visit '/tags/whatever'
    expect(page).not_to have_content('Makers Academy')
    expect(page).to have_content('Hi')
    expect(page).to have_content('Yo')
  end
end