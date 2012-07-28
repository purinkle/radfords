class DestroySession < Spinach::FeatureSteps
  include Actors
  include Links

  Then 'a success flash is shown' do
    should have_selector(
      'div.alert-success',
      text: 'You successfully signed out'
    )
  end
end
