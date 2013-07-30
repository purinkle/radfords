### GIVEN ###

Given(/^I am signed in$/) do
  FactoryGirl.create(:user)
  signin_page = SigninPage.new("purinkle@example.com", "foobar")

  visit signin_path

  signin_page.sign_in
end

### WHEN ###

When(/^I create a session with invalid data$/) do
  signin_page = SigninPage.new

  visit signin_path

  signin_page.sign_in
end
