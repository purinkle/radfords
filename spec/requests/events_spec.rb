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

  describe "sign in/out" do
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path

        fill_in :email,    :with => ""
        fill_in :password, :with => ""

        click_button

        response.should have_selector( "div.flash.error", :content => "Invalid" )
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)

        visit signin_path

        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password

        click_button

        controller.should be_signed_in

        click_link "Sign out"

        controller.should_not be_signed_in
      end
    end
  end
end