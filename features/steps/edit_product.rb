class EditProduct < Spinach::FeatureSteps
  include Forms::Product
  include Links
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

  Then 'the product\'s page is displayed' do
    should have_selector('title', text: 'Blackcurrant Jam')
  end
end
