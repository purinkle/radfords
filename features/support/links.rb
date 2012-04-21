module Links
  include Spinach::DSL

  def click_edit
    click_link 'Edit'
  end

  When 'I click an "Edit" link' do
    click_edit
  end

  When 'I click the "Back" link' do
    click_link 'Back'
  end

  When 'I click the "Cancel" link' do
    click_link 'Cancel'
  end

  When 'I click the "Edit" link' do
    click_edit
  end

  When 'I click the "New Product" link' do
    click_link 'New Product'
  end

  When 'I click the "Products" link' do
    click_link 'Products'
  end

  When 'I click the "Sign Out" link' do
    click_link 'Sign out'
  end

  When 'I click a product link' do
    click_link 'Lorem Ipsum'
  end

  When 'I click the first product link' do
    click_link 'Blueberry and Apple Preserve'
  end

  When 'I click the "Basket" link' do
    find('.nav li:last-child a').click
  end
end
