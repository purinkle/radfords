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
end
