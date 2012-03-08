class EditProduct < Spinach::FeatureSteps
  include Forms::Product
  include Links
  include Paths
  include Sessions

  feature 'Edit product'
  Then 'the product\'s title is displayed' do
    should have_selector('input[value="Lorem Ipsum"]')
  end

  And 'the product\'s description is displayed' do
    should have_selector('textarea', text: 'Wibbles are fun!')
  end

  And 'the product\'s image URL is displayed' do
    should have_selector('input[value="lorem.jpg"]')
  end

  And 'the product\'s price is displayed' do
    should have_selector('input[value="19.95"]')
  end

  And 'a "Show" link is displayed' do
    should have_selector('a', text: 'Show')
  end

  Then 'the updated product\'s page is displayed' do
    should have_selector('title', text: 'Blackcurrant Jam')
  end

  Then 'the product\'s page is displayed' do
    should have_selector('title', text: 'Lorem Ipsum')
  end

  Then 'a "Back" link is displayed' do
    should have_selector('a', text: 'Back')
  end

  Then 'the products index is displayed' do
    should have_selector('title', text: 'Products')
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

  And 'the updated description is displayed' do
    should have_selector('p', text: 'Bursting with blackcurrant flavour')
  end

  And 'the updated image is displayed' do
    should have_selector('img[src$="blackcurrant.jpg"]')
  end

  And 'the updated price is displayed' do
    should have_selector('p', text: '3.00')
  end

  Then 'a "Title can\'t be blank" message is displayed' do
    should have_selector('li', text: 'Title can\'t be blank')
  end

  Then 'a "Description can\'t be blank" message is displayed' do
    should have_selector('li', text: 'Description can\'t be blank')
  end

  Then 'an "Image URL can\'t be blank" message is displayed' do
    should have_selector('li', text: 'Image url can\'t be blank')
  end

  Then 'a "Price is not a number" message is displayed' do
    should have_selector('li', text: 'Price is not a number')
  end

  Then 'a "Price must be greater than or equal to 0.01" message is displayed' do
    should have_selector('li', text: 'Price must be greater than or equal to 0.01')
  end

  Then 'a "Title has already been taken" message is displayed' do
    should have_selector('li', text: 'Title has already been taken')
  end

  Then 'the error count is displayed' do
    should have_selector('h2', text: '4 errors')
  end

  Then 'I am redirected to the sign in page' do
    should have_selector('title', text: 'Sign In')
  end

  Then 'a sign in message is displayed' do
    should have_selector('.error', text: 'Please sign in to access this page.')
  end
end
