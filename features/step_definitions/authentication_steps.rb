Given(/^a user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  @user = create(:user, email: email, password: password)
end

Given(/^I am logged in$/) do
  user_data = { email: 'test@test.com', password: 'password' }
  person = create(:person, user: create(:user, user_data))
  @user = person.user

  step 'I access "/users/sign_in"'
  step "I fill in \"Email\" with \"#{user_data[:email]}\""
  step "I fill in \"Password\" with \"#{user_data[:password]}\""
  step 'I click on the "Log in" button'
end
