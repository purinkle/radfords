require 'spec_helper'

describe 'Events' do
  describe 'creation' do
    describe 'failure' do
      it 'should not make an event' do
        lambda do
          visit new_event_path
          
          fill_in 'Name',           :with => ''
          fill_in 'Takes place on', :with => ''
          fill_in 'Location',       :with => ''
          
          click_button
          
          response.should render_template('events/new')
          response.should have_selector('div#error_explanation')
        end.should_not change( Event, :count )
      end
    end
    
    describe 'success' do
      it 'should make an event' do
        lambda do
          visit new_event_path
          
          fill_in 'Name',           :with => 'Macclesfield Farmers Market'
          fill_in 'Takes place on', :with => '2 October 2011'
          fill_in 'Location',       :with => 'Town Hall, Macclesfield'
          
          click_button
          
          response.should render_template('events/show')
        end.should change( Event, :count ).by(1)
      end
    end
  end
end