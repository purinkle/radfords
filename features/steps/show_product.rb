class ShowProduct < Spinach::FeatureSteps
  include Forms::Product
  include Links
  include Sessions

  feature 'Show product'
  Then 'the product\'s title is displayed' do
    should have_selector('p', text: 'Lorem Ipsum')
  end

  And 'the product\'s description is displayed' do
    should have_selector('p', text: 'Wibbles are fun!')
  end

  And 'an image of the product is displayed' do
    should have_selector('img[src$="lorem.jpg"]')
  end

  And 'the product\'s price is displayed' do
    should have_selector('p', text: '19.95')
  end

  Then 'there is an "Edit" link' do
    should have_selector('a', text: 'Edit')
  end

  Then 'the "Edit Product" page is displayed' do
    should have_selector('title', text: 'Edit Product')
  end
end
