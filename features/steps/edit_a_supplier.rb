class EditASupplier < Spinach::FeatureSteps
  feature 'Edit a supplier'
  Given 'I am on the show supplier page' do
    visit new_supplier_path

    fill_in 'Name', with: 'Shannon Sims'
    fill_in 'Address', with: '8 Terrick Road, Eilean Darach IV23 0HE'
    fill_in 'Telephone Number', with: '07820 955869'

    click_button('Add supplier')
  end

  When 'I click the edit supplier link' do
    click_link 'Edit'
  end

  Then 'I should be shown the edit supplier page' do
    should have_selector(:title, content: 'Edit supplier')
  end
end