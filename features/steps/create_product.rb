class CreateProduct < Spinach::FeatureSteps
  include Actors
  include Paths

  Then 'I am redirected to the "Sign In" page' do
    should have_selector('title', text: 'Sign In')
  end

  Then 'there is a "Title" field' do
    should have_selector(:product_title)
  end

  Then 'there is a "Description" field' do
    should have_selector(:product_description)
  end

  Then 'there is an "Image URL" field' do
    should have_selector(:product_image_url)
  end

  Then 'there is a "Create Product" button' do
    should have_button('Create Product')
  end

  Then 'there is a "Cancel" link' do
    should have_link('Cancel')
  end
end
