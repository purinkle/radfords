module Links
  include Spinach::DSL

  def click_edit
    click_link 'Edit'
  end

  def click_show
    click_link 'Show'
  end

  When 'I click a "Show" link' do
    click_show
  end

  When 'I click an "Edit" link' do
    click_edit
  end

  When 'I click the "Back" link' do
    click_link 'Back'
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

  When 'I click the "Show" link' do
    click_show
  end
end
