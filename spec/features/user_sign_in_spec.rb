require 'spec_helper'
feature 'user signs in' do

  before(:each) do
    User.create(email: 'ah.com',
                password: 'works',
                password_confirmation: 'works')
  end
  scenario 'with correct credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, ah.com')
    sign_in('ah.com', 'works')
    expect(page).to have_content('Welcome, ah.com')
  end

  scenario 'with incorrect credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, ah.com')
    sign_in('ah.com', 'fails')
    expect(page).not_to have_content('Welcome, ah.com')
  end

  def sign_in(email, password)
    visit '/sessions/new'
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign in'
  end
end