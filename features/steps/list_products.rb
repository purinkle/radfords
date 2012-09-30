class ListProducts < Spinach::FeatureSteps
  include Actors
  include Links
  include Paths
  include Products

  Then 'a "New Product" link is shown' do
    should have_link('New Product')
  end

  Then 'a "no products" message is shown' do
    should have_selector('div.no-content', text: 'no products')
  end

  Then 'I am redirected to the "Sign In" page' do
    should have_selector('title', text: 'Sign In')
  end

  Then 'the "New Product" page is shown' do
    should have_selector('title', text: 'New Product')
  end

  Then 'the title is correct' do
    should have_selector('title', text: 'Products')
  end
end