class IndexEvents < Spinach::FeatureSteps
  include Actors
  include Events
  include Paths

  Given 'I am logged in' do
    email = 'user@example.com'
    password = 'password'

    User.create({
      name: 'Example User',
      email: email,
      password: password,
      password_confirmation: password
    })

    visit signin_path

    fill_in 'session_email', with: email
    fill_in 'session_password', with: password

    click_button 'Sign in'
  end

  And 'some events have been created' do
    Event.create({
      name: 'Foo',
      takes_place_on: 2.days.from_now,
      location: 'Bar'
    })
    Event.create({
      name: 'Baz',
      takes_place_on: 1.day.from_now,
      location: 'Qux'
    })

    30.times do
      Event.create({
        name: 'Wibble',
        takes_place_on: 1.week.from_now,
        location: 'Wobble'
      })
    end
  end

  When 'I click the "Events" link' do
    click_link('Events')
  end

  Then 'each event is displayed' do
    %w(Foo Baz).each do |event|
      should have_selector('td', text: event)
    end
  end

  Then 'the "Previous" link is disabled' do
    should have_selector('span.disabled', text: 'Previous')
  end

  And 'the link to the second page is displayed' do
    should have_selector(
      'a',
      {
        href: '/events?page=2',
        text: '2'
      }
    )
  end

  And 'the "Next" link is displayed' do
    should have_selector(
      'a',
      {
        href: '/events?page=2',
        text: 'Next'
      }
    )
  end

  Then 'there is a successful deletion flash' do
    should have_selector 'div', text: 'The event was deleted successfully.'
  end

  Then 'the event is not listed' do
    should_not have_selector 'tbody tr'
  end
end
