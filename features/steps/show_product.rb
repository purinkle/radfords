class ShowProduct < Spinach::FeatureSteps
  include Forms::Product
  include Links
  include Paths
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

  And 'there is an "Edit" link' do
    should have_selector('a', text: 'Edit')
  end

  And 'there is a "Back" link' do
    should have_selector('a', text: 'Back')
  end

  Then 'the "Edit Product" page is displayed' do
    should have_selector('title', text: 'Edit Product')
  end

  Then 'the "Products" page is displayed' do
    should have_selector('title', text: 'Products')
  end

  Then 'the updated title is displayed' do
    should have_selector('p', text: 'Blackcurrant Jam')
  end

  And 'the updated description is displayed' do
    should have_selector('p', text: 'Bursting with blackcurrant flavour')
  end

  And 'the updated image is displayed' do
    should have_selector('img[src$="blackcurrant.jpg"]')
  end

  And 'the updated price is displayed' do
    should have_selector('p', text: '3.00')
  end

  And 'the product\'s price is displayed' do
    should have_selector('p', text: '19.95')
  end

  Then 'a "Delete" button is displayed' do
    should have_selector('input[value="Delete"]')
  end

  Then 'the product is not displayed' do
    should_not have_selector('h3', text: 'Lorem Ipsum')
  end
end
