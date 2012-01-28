class IndexProducts < Spinach::FeatureSteps
  include Forms::Product
  include Links
  include Sessions

  Then 'the product\'s title is displayed' do
    should have_selector('td', text: 'Lorem Ipsum')
  end

  And 'the product\'s description is displayed' do
    should have_selector('td', text: 'Wibbles are fun!')
  end

  And 'the product\'s image is displayed' do
    should have_selector('img[src$="lorem.jpg"]')
  end

  And 'the product\'s price is displayed' do
    should have_selector('td', text: '19.95')
  end

  And 'there is a "Show" link' do
    should have_selector('a', text: 'Show')
  end

  And 'the product\'s page is displayed' do
    should have_selector('title', text: 'Lorem Ipsum')
  end

  And 'there is an "Edit" link' do
    should have_selector('a', text: 'Edit')
  end

  And 'there is a "Delete" button' do
    should have_selector('input[value="Delete"]')
  end

  Then 'the product\'s page is displayed' do
    should have_selector('title', text: 'Lorem Ipsum')
  end

  Then 'the "Edit Product" page is displayed' do
    should have_selector('title', text: 'Edit Product')
  end

  Then 'I am redirected back to the "Products" page' do
    should have_selector('title', text: 'Products')
  end

  And 'the product is no longer displayed' do
    should_not have_selector('td', text: 'Lorem Ipsum')
  end

  And 'a success flash is displayed' do
    should have_selector('.success', text: 'deleted the product')
  end
end
