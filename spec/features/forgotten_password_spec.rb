feature 'forgotten password' do
  before(:each) do
    User.create(email: "ah@ah.com", password: '123', password_confirmation: '123')
  end

  scenario 'user forgets password and submits email on lost password form' do
      fill_form("ah@ah.com")
      expect(page).to have_content("Thanks, you will receive an email shortly")
  end

  def fill_form(email = "ah@ah.com")
    visit '/sessions/passwordlost'
    fill_in :email, with: email
    click_button "Forgot Password"
  end
end