module Links
  include Spinach::DSL

  When 'I click the "Back" link' do
    click_link 'Back'
  end

  When 'I click the "Edit" link' do
    click_link 'Edit'
  end

  When 'I click the "New Product" link' do
    click_link 'New Product'
  end

  When 'I click the "Products" link' do
    click_link 'Products'
  end
end
