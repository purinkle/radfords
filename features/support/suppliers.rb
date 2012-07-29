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
end
