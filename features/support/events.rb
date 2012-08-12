module Events
  include Spinach::DSL

  Given 'some events have been created' do
    FactoryGirl.create :event
  end

  When 'I click the "Delete Event" button' do
    click_button 'Delete Event'
  end

  When 'I click the "Cancel" link' do
    click_link 'Cancel'
  end
end