# ** encoding: utf-8 **

class ShowBasket < Spinach::FeatureSteps
  include Actors
  include Baskets
  include Links
  include Paths
  include Products

  Then 'the products are listed' do
    within('tr:nth-of-type(1)') do
      find('td:nth-of-type(1)').text.should == '2 ×'

      find('td:nth-of-type(2) img')[:src].should ==
        '/images/products/1/small/apple_and_blueberry_preserve.jpg'

      find('td:nth-of-type(3)').text.should == 'Blueberry and Apple Preserve'
    end

    within('tr:nth-of-type(2)') do
      find('td:nth-of-type(1)').text.should == '1 ×'

      find('td:nth-of-type(2) img')[:src] ==
        '/images/products/1/small/apricot_and_ginger§_preserve.jpg'

      find('td:nth-of-type(3)').text.should == 'Apricot and Ginger Preserve'
    end
  end

  Then 'I am redirected to the Products page' do
    find('title').text.should =~ /^Products/
  end

  Then 'an "Invalid basket" message is displayed' do
    find('.alert-error').text.should =~ /Invalid basket\.$/
  end

  Then 'a "Checkout" button is displayed' do
    find('.btn-primary').value.should == 'Checkout'
  end

  Then 'an "Empty basket" button is displayed' do
    find('.btn-danger').value.should == 'Empty basket'
  end

  Then 'the total price for each product is displayed' do
    find('tr:nth-of-type(1) .item_price').text.should == '£5.70'
    find('tr:nth-of-type(2) .item_price').text.should == '£2.85'
  end

  Then 'the basket\'s total price is displayed' do
    find('.total_line .total_cell').text.should == '£8.55'
  end

  Then 'the new order page is shown' do
    find('title').text.should =~ /^New order/
  end
end