# ** encoding: utf-8 **

class ShowOrder < Spinach::FeatureSteps
  include Orders
  include Paths
  include Sessions

  Then 'the order\'s details are shown' do
    within('dl') do
      find('dd:nth-of-type(1)').text.should == '1'
      find('dd:nth-of-type(2)').text.should == 'Randall Waters'
      find('dd:nth-of-type(3)').text.should == '20383 Sawayn Inlet'
      find('dd:nth-of-type(4)').text.should == 'waters.randall@kerluke.info'
    end
  end

  Then 'the order\'s contents are listed' do
    within('tbody tr:nth-of-type(1)') do
      find('td:nth-of-type(1) img')[:src].should =~
        /^\/images\/products\/1\/small\/image\.jpg/

      find('td:nth-of-type(2)').text.should == 'Blueberry and Apple Preserve'
      find('td:nth-of-type(3)').text.should == '2'
      find('td:nth-of-type(4)').text.should == '£5.70'
    end

    within('tbody tr:nth-of-type(2)') do
      find('td:nth-of-type(1) img')[:src].should =~
        /^\/images\/products\/2\/small\/image\.jpg/

      find('td:nth-of-type(2)').text.should == 'Apricot and Ginger Preserve'
      find('td:nth-of-type(3)').text.should == '3'
      find('td:nth-of-type(4)').text.should == '£8.55'
    end
  end
end