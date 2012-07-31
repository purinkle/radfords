module Suppliers
  include Spinach::DSL

  When 'I click the "Cancel" link' do
    click_link 'Cancel'
  end

  Given 'some suppliers have been created' do
    VCR.use_cassette 'supplier/jack_green' do
      FactoryGirl.create :supplier
    end
  end

  When 'I click a supplier\'s destroy button' do
    click_button 'Delete'
  end

  When 'I click the "Update Supplier" button' do
    VCR.use_cassette 'supplier/jack_green' do
      click_button 'Update Supplier'
    end
  end

  When 'I fill in the form correctly' do
    fill_in 'Name', with: 'Jack Green'
    fill_in 'Address', with: '4 Buckingham Road, Thorpe Larches TS21 6FF'
    fill_in 'Telephone number', with: '07735 522248'
  end

  When 'I click the "Create Supplier" button' do
    VCR.use_cassette 'supplier/jack_green' do
      click_button 'Create Supplier'
    end
  end
end
