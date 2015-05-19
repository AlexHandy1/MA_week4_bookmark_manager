require 'capybara/rspec'
require 'link'
require 'tag'

feature 'User can add links to the site' do
  scenario 'and creates a new link on homepage' do
    expect(Link.count).to eq(0)
    visit '/'
    add_link('Makers Academy', 'http://www.makersacademy.com/')
    expect(Link.count).to eq(1)

    link = Link.first

    expect(link.title).to eq "Makers Academy"
    expect(link.url).to eq 'http://www.makersacademy.com/'
  end

  scenario 'with a few tags' do
    visit '/'
    add_link('Makers Academy', 'http://www.makersacademy.com/', %w(education ruby))
    link = Link.first
    expect(link.tags.map(&:text)).to include 'education', 'ruby'
  end

  def add_link(title, url, tags = [])
    within('#new-link') do
      fill_in 'title', with: title
      fill_in 'url',  with: url
      fill_in 'tags', with: tags.join(' ')
      click_button "Add_link"
    end
  end
end