module Products
  include Spinach::DSL

  Given 'no products have been created' do; end

  When 'I leave the "Title" field blank' do
    fill_in :product_title, with: %q{}
  end

  When 'I submit the "New Product" form' do
    click_button 'Create Product'
  end

  When 'I use an existing title' do
    product = create_valid_product
    fill_in :product_title, with: product.title
  end

  def create_valid_product
    FactoryGirl.create(:product)
  end
end
