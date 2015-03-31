def sign_in(user)
  navigate_to_sign_in
  fill_in_and_submit_sign_in(user)
end

def navigate_to_sign_in
  visit root_path
  within('.navbar') do
    click_link('Sign In')
  end
end

def fill_in_and_submit_sign_in(user)
  fill_in('user[email]', with: user.email)
  fill_in('user[password]', with: user.password)
  click_button('Log in')
end