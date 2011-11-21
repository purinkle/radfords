require 'spinach/capybara'

class EditASupplier < Spinach::FeatureSteps
  feature 'Edit a supplier'
  Given 'I am on the show supplier page' do
    visit new_supplier_path

    fill_in 'Name', with: 'Shannon Sims'
    fill_in 'Address', with: '8 Terrick Road, Eilean Darach IV23 0HE'
    fill_in 'Telephone Number', with: '07820 955869'

    click_button 'Add supplier'
  end

  When 'I click the edit supplier link' do
    click_link 'Edit'
  end

  Then 'I should be shown the edit supplier page' do
    should have_selector('title', text: 'Edit supplier')
  end

  Given 'I am on the edit supplier page' do
    visit new_supplier_path

    fill_in 'Name', with: 'Shannon Sims'
    fill_in 'Address', with: '8 Terrick Road, Eilean Darach IV23 0HE'
    fill_in 'Telephone Number', with: '07820 955869'

    click_button 'Add supplier'
    click_link 'Edit'
  end

  When 'I complete the form with correct information' do
    fill_in 'Name', with: 'Edward Myers'
    fill_in 'Address', with: '22 Tonbridge Road, Consall ST9 8FH'
    fill_in 'Telephone number', with: '07843 419411'
  end

  And 'I submit the form' do
    click_button 'Update'
  end

  Then 'the should be shown the show supplier page' do
    should have_selector('title', text: 'Edward Myers')
  end

  # And 'a success message should be displayed' do
  #
  # end
end