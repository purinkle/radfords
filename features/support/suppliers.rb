module Suppliers
  include Spinach::DSL

  When 'I click the "Cancel" link' do
    click_link 'Cancel'
  end
end
