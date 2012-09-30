class CreateProduct < Spinach::FeatureSteps
  include Actors
  include Paths

  Then 'I am redirected to the "Sign In" page' do
    should have_selector('title', text: 'Sign In')
  end
end
