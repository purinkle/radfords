class DestroyBasket < Spinach::FeatureSteps
  include Actors
  include Paths
  include Products

  Then 'I am redirected to "Products"' do
    find('title').text.should =~ /^Products/
  end

  Then '"Your basket is currently empty" is displayed' do
    find('.alert-info').text.should =~ /Your basket is currently empty\.$/
  end
end
