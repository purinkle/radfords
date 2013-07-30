### GIVEN ###

Given(/^there is (\d+) supplier$/) do |size|
  VCR.use_cassette("create supplier") do
    FactoryGirl.create(:supplier)
  end

  expect(Supplier.all.size).to eql size.to_i
end

### WHEN ###

When(/^I create an invalid supplier$/) do
  new_supplier_page = NewSupplierPage.new

  visit new_supplier_path

  new_supplier_page.create
end

When(/^I create a valid supplier$/) do
  new_supplier_page = NewSupplierPage.new(
    "Foo Bar",
    "4 Buckingham Road, Thorpe Larches TS21 6FF",
    "01234 567890"
  )

  visit new_supplier_path

  new_supplier_page.create
end

When(/^I delete the supplier$/) do
  outlets_page = OutletsPage.new

  visit outlets_path

  outlets_page.delete_supplier
end

When(/^I try to create a supplier$/) do
  outlets_page = OutletsPage.new

  visit outlets_path

  outlets_page.create_supplier
end

When(/^I try to edit the supplier$/) do
  outlets_page = OutletsPage.new

  visit outlets_path

  outlets_page.edit_supplier
end

When(/^I update the supplier with valid data$/) do
  supplier = Supplier.first
  edit_supplier_page = EditSupplierPage.new(
    "My Shop",
    "1 My Street, My Town AA1 1AA",
    "http://example.com",
    "01234 567890"
  )

  visit edit_supplier_path(supplier)

  edit_supplier_page.update
end

When(/^I update the supplier with invalid data$/) do
  supplier = Supplier.first
  edit_supplier_page = EditSupplierPage.new

  visit edit_supplier_path(supplier)

  edit_supplier_page.update
end

### THEN ###

Then(/^I see (\d+) suppliers$/) do |count|
  expect(page).to have_selector(".suppliers li", count: count.to_i)
end

Then(/^the supplier's address is pre\-populated$/) do
  field = find_field("Address")
  expect(field.value).to eql "4 Buckingham Road, Thorpe Larches TS21 6FF"
end

Then(/^the supplier's name is pre\-populated$/) do
  field = find_field("Name")
  expect(field.value).to eql "Jack Green"
end

Then(/^the supplier's telephone number is pre\-populated$/) do
  field = find_field("Telephone number")
  expect(field.value).to eql "07735 522248"
end

Then(/^the supplier's website is pre\-populated$/) do
  field = find_field("Website")
  expect(field.value).to eql "http://soldierresources.com/"
end
