class IndexOrders < Spinach::FeatureSteps
  include Orders
  include Paths
  include Sessions

  Then 'each order is shown' do
    within('tbody tr:nth-of-type(1)') do
      find('td:nth-of-type(1)').text.should == '1'
      find('td:nth-of-type(2)').text.should == 'Randall Waters'
      find('td:nth-of-type(3)').text.should == '20383 Sawayn Inlet'
      find('td:nth-of-type(4)').text.should == 'waters.randall@kerluke.info'
    end

    within('tbody tr:nth-of-type(2)') do
      find('td:nth-of-type(1)').text.should == '2'
      find('td:nth-of-type(2)').text.should == 'Retta O\'Keefe'
      find('td:nth-of-type(3)').text.should == '87920 Fay Fields'
      find('td:nth-of-type(4)').text.should == 'o_keefe_retta@langkshlerin.us'
    end
  end

  Then 'there\'s a link to each order' do
    within('tbody tr:nth-of-type(1) td:nth-of-type(1)') do
      find('a')[:href].should == '/orders/1'
    end
  end
end