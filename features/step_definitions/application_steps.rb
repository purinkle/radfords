### WHEN ###

When(/^I follow the "(.*?)" link$/) do |link|
  click_link link
end

### THEN ###

Then(/^I see an? "(.*?)" alert$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I see a "(.*?)" message$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I see a "(.*?)" notice$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I see the "(.*?)" page$/) do |title|
  expect(page.title).to eql "#{title} | Radfords of Somerford"
end
