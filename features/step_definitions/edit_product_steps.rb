### THEN ###

Then(/^I see the product's preview photo$/) do
  expect(page).to have_xpath "//img[contains(@src, \"/preview/photo.jpg\")]"
end
