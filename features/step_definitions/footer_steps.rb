When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I don't see the "(.*?)" link$/) do |link|
  expect(page).to_not have_link link
end
