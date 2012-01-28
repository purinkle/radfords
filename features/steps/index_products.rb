class IndexProducts < Spinach::FeatureSteps
  include Forms::Product
  include Links
  include Sessions

  Then 'the product\'s title is displayed' do
    should have_selector('td', text: 'Lorem Ipsum')
  end
end
