module Products
  include Spinach::DSL

  Given 'no products have been created' do; end

  When 'I leave the "Title" field blank' do
    fill_in :product_title, with: %q{}
  end

  When 'I submit the "New Product" form' do
    click_button 'Create Product'
  end
end
