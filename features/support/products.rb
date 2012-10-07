module Products
  include Spinach::DSL

  Given 'no products have been created' do; end

  When 'I click the "Cancel" link' do
    click_link('Cancel')
  end

  When 'I create a valid product' do
    fill_in 'Title', with: valid_product.title
    click_button 'Create Product'
  end
  
  When 'I leave the "Title" field blank' do
    fill_in 'Title', with: %q{}
  end

  When 'I submit the "New Product" form' do
    click_button 'Create Product'
  end

  When 'I use an existing title' do
    valid_product.save
    fill_in 'Title', with: valid_product.title
  end

  def valid_product
    @product ||= FactoryGirl.build(:product)
  end
end
