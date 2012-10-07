class CreateProduct < Spinach::FeatureSteps
  include Actors
  include Paths
  include Products

  Then 'I am redirected to the "Sign In" page' do
    should have_selector('title', text: 'Sign In')
  end

  Then 'I am redirected to the product\'s page' do
    should have_selector('title', text: valid_product.title)
  end

  Then 'I stay on the "New Product" page' do
    should have_selector('title', text: 'New Product')
  end

  Then 'the "Products" page is shown' do
    should have_selector('title', text: 'Products')
  end

  Then 'there is a "Cancel" link' do
    should have_link('Cancel')
  end

  Then 'there is a "Create Product" button' do
    should have_button('Create Product')
  end

  Then 'there is an "Image URL" field' do
    should have_selector(:product_image_url)
  end

  Then 'there is a "Description" field' do
    should have_selector(:product_description)
  end

  And 'there is a "product was created successfully" message' do
    should have_selector(
      '.alert-success',
      text: 'product was created successfully'
    )
  end

  Then 'there is a "Title can\'t be blank" error' do
    should have_selector('li', text: 'Title can\'t be blank')
  end

  Then 'there is a "Title has already been taken" error' do
    should have_selector('li', text: 'Title has already been taken')
  end

  Then 'there is a "Title" field' do
    should have_selector(:product_title)
  end
end
