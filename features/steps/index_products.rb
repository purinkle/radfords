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

  And 'there is an "Edit" link' do
    should have_selector('a', text: 'Edit')
  end

  And 'the "Edit Product" page is displayed' do
    should have_selector('title', text: 'Edit Product')
  end
end