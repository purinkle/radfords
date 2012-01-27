class CreateProduct < Spinach::FeatureSteps
  include Forms::Product
  include Links
  include Sessions

  feature 'Create product'
  Then 'there is a "New Product" link' do
    should have_selector('a', text: 'New Product')
  end

  Then 'the "New Product" page is displayed' do
    should have_selector('title', text: 'New Product')
  end

  Then 'there is a "Back" link' do
    should have_selector('a', text: 'Back')
  end

  Then 'the "Products" page is displayed' do
    should have_selector('title', text: 'Products')
  end

  Then 'I am shown a product page' do
    should have_selector('title', text: 'Lorem Ipsum')
  end
end
