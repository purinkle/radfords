class DestroySupplier < Spinach::FeatureSteps
  include Actors
  include Paths
  include Suppliers

  Then 'a success flash is shown' do
    should have_selector(
      'div.alert-success',
      text: 'The supplier was destroyed successfully.'
    )
  end
end
