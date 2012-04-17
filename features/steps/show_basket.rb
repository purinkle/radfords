# ** encoding: utf-8 **

class ShowBasket < Spinach::FeatureSteps
  include Actors
  include Paths
  include Products

  Then 'the product is listed' do
    find('.items li:first-child').text.should == '1 × Blueberry and Apple Preserve'
  end
end
