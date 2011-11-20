require 'spinach/capybara'

module SupplierInformation
  def supplier_name
    'Shannon Sims'
  end

  def supplier_address
    '8 Terrick Road, Eilean Darach IV23 0HE'
  end

  def supplier_telephone_number
    '07820 955869'
  end
end

class CreateASupplier < Spinach::FeatureSteps
  include SupplierInformation

  feature 'Create a supplier'
  Given 'I am on the new supplier page' do
    visit outlets_path
    click_link 'New supplier'
  end

  When 'I complete the form correctly' do
    fill_in 'Name', with: supplier_name
    fill_in 'Address', with: supplier_address
    fill_in 'Telephone Number', with: supplier_telephone_number
  end

  When 'I complete the form incorrectly' do
    fill_in 'Name', with: ''
    fill_in 'Address', with: ''
    fill_in 'Telephone Number', with: ''
  end

  And 'I submit the form' do
    click_button('Add supplier')
  end

  Then 'I should be shown the page for the supplier' do
    should have_selector(:title, content: supplier_name)
  end

  Then 'I should be shown the new supplier page' do
    should have_selector(:title, content: 'New supplier')
  end

  And 'all the suppliers details should be listed' do
    should have_selector('p', content: supplier_name)
    should have_selector('p', content: supplier_address)
    should have_selector('p', content: supplier_telephone_number)
  end
end
