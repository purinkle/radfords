class DestroyBasket < Spinach::FeatureSteps
  include Actors
  include Paths
  include Products

  Then 'I am redirected to "Products"' do
    find('title').text.should =~ /^Products/
  end
end
