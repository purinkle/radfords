Given(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I see the "(.*?)" page$/) do |title|
  expect(page.title).to eql "#{title} | Radfords of Somerford"
end
