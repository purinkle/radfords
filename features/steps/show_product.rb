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
end
