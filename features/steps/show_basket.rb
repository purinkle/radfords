class ShowBasket < Spinach::FeatureSteps
  include Actors
  include Paths
  include Products

  Then 'the product is listed' do
    find('li:first-child').text == 'Blueberry and Apple Preserve'
  end
end
