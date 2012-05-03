class NewOrder < Spinach::FeatureSteps
  include Actors
  include Baskets
  include Links
  include Orders
  include Paths
  include Products

  Then 'there is a "Name" field' do
    within('form li:nth-of-type(1)') do
      find('label').text.should == 'Name'
      should have_selector('input[type=text]#order_name')
    end
  end

  Then 'there is an "Address" field' do
    within('form li:nth-of-type(2)') do
      find('label').text.should == 'Address'
      should have_selector('textarea#order_address')
    end
  end

  Then 'there is an "Email" field' do
    within('form li:nth-of-type(3)') do
      find('label').text.should == 'Email'
      should have_selector('input[type=email]#order_email')
    end
  end

  Then 'there is a "Place Order" button' do
    within('form li:last-child') do
      find('input[type=submit]').value.should == 'Place Order'
    end
  end

  Then 'I am shown the products page' do
    find('title').text.should =~ /^Products/
  end

  Then 'I am shown the new order page' do
    find('title').text.should =~ /^New order/
  end

  Then 'a "Name can\'t be blank" message is shown' do
    within('.alert-error ul') do
      find('li:nth-of-type(1)').text.should == 'Name can\'t be blank'
    end
  end

  Then 'an "Address can\'t be blank" message is shown' do
    within('.alert-error ul') do
      find('li:nth-of-type(2)').text.should == 'Address can\'t be blank'
    end
  end

  Then 'an "Email can\'t be blank" message is shown' do
    within('.alert-error ul') do
      find('li:nth-of-type(3)').text.should == 'Email can\'t be blank'
    end
  end
end
