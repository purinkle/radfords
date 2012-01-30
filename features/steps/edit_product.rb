class EditProduct < Spinach::FeatureSteps
  include Forms::Product
  include Links
  include Sessions

  feature 'Edit product'
  Then 'the product\'s title is displayed' do
    should have_selector('input[value="Lorem Ipsum"]')
  end
end
