# ** encoding: utf-8 **

class ShowBasket < Spinach::FeatureSteps
  include Actors
  include Paths
  include Products

  Then 'the product is listed' do
    find('.items li:first-child').text.should == '1 × Blueberry and Apple Preserve'
  end

  Then 'I am redirected to the Products page' do
    find('title').text.should =~ /^Products/
  end

  Then 'an "Invalid basket" message is displayed' do
    find('.alert-error').text.should =~ /Invalid basket\.$/
  end

  Then 'an "Empty basket" button is displayed' do
    find('.btn-danger').value.should == 'Empty basket'
  end
end
