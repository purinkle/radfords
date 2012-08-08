module Events
  include Spinach::DSL

  Given 'some events have been created' do
    FactoryGirl.create :event
  end
end