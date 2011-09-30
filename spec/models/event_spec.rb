# == Schema Information
#
# Table name: events
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  takes_place_on :date
#  location       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Event do
  before (:each) do
    @attr = {
      :name           => 'Rob\'s Birthday',
      :takes_place_on => '7 June 1985',
      :location       => 'Leighton Hospital, Crewe'
    }
  end
  
  it 'should create a new instance given valid attributes' do
    Event.create!(@attr)
  end
  
  it 'should require a name' do
    no_name_event = Event.create( @attr.merge( :name => '' ) )
    no_name_event.should_not be_valid
  end
  
  it 'should require a date' do
    no_date_event = Event.create( @attr.merge( :takes_place_on => '' ) )
    no_date_event.should_not be_valid
  end
  
  it 'should accept valid dates' do
    dates = ['29 September 2011', '29/09/11', '29-SEP-2011']
    
    dates.each do |date|
      valid_date_event = Event.create( @attr.merge( :takes_place_on => date ) )
      valid_date_event.should be_valid
    end
  end
  
  it 'should reject invalid dates' do
    dates = %w[friday 13 user@example.com]
    
    dates.each do |date|
      invalid_date_event = Event.create( @attr.merge( :takes_place_on => date ) )
      invalid_date_event.should_not be_valid
    end
  end
  
  it 'should require a location' do
    no_location_event = Event.create( @attr.merge( :location => '' ) )
    no_location_event.should_not be_valid
  end
end
