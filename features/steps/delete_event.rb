class DeleteEvent < Spinach::FeatureSteps
  include Actors
  include Paths

  Then 'the sign in page is shown' do
    should have_selector 'title', text: 'Sign In'
  end
end
