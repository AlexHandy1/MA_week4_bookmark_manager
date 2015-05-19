feature 'user signs out' do

  before(:each) do
    User.create(email: 'ah.com',
                password: 'works',
                password_confirmation: 'work')
  end

  scenario 'while being signed in' do
    sign_in('ah.com', 'works')
    click_button 'Sign out'
    expect(page).to have_content('Good bye!')
    expect(page).not_to have_content('Welcome, ah.com')
  end

  #extracte into new structure
  def sign_in(email, password)
    visit '/sessions/new'
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign in'
  end

end