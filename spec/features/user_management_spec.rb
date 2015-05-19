feature 'User signs up' do

  scenario 'and they are registered on website' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'with a password that does not match' do
    expect { sign_up('a@a.com', 'pass', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Password does not match the confirmation')
  end

  def sign_up(email = 'alice@example.com', password = 'oranges!', password_confirmation = 'oranges!')
    expect { sign_up('h@w.com', 'pass', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Password does not match the confirmation')
  end

  #note, different to tutorial but lets see if works
  scenario "cant register the same user twice" do
    expect { sign_up('h@w.com', 'pass', 'pass') }.to change(User, :count).by(1)
    expect { sign_up('h@w.com', 'pass', 'pass') }.to change(User, :count).by(0)
    expect(page).to have_content('This email is already taken')
  end

  def sign_up email = 'alice@example.com', password = 'oranges!', password_confirmation = 'oranges!'
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end
end