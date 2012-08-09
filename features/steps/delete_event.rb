class DeleteEvent < Spinach::FeatureSteps
  include Actors
  include Events
  include Paths

  Then 'the sign in page is shown' do
    should have_selector 'title', text: 'Sign In'
  end

  Then 'the confirmation page is shown' do
    should have_selector 'title', text: 'Delete Event'
  end

  Then 'there is a "Delete Event" button' do
    should have_selector '.btn-primary[value="Delete Event"]'
  end

  Then 'there is a "Cancel" link' do
    should have_selector '.btn', text: 'Cancel'
  end

  Then 'the events index is shown' do
    should have_selector 'title', text: 'Listing events'
  end

  Then 'there is an invalid event flash' do
    should have_selector 'div', text: 'The event you selected doesn\'t exist.'
  end
end
