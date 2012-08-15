module Events
  include Spinach::DSL

  Given 'an event has been created' do
    FactoryGirl.create :event
  end

  Given 'some events have been created' do
    FactoryGirl.create :event
  end

  When 'I click the "Delete Event" button' do
    click_button 'Delete Event'
  end

  When 'I click the "Cancel" link' do
    click_link 'Cancel'
  end

  When 'I click the "Destroy" link' do
    click_link 'Destroy'
  end
end