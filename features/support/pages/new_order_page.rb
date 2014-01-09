class NewOrderPage
  include Capybara::DSL
  include RSpec::Matchers

  def create(options = {})
    fill_in('Name', with: options.fetch(:name, ''))
    fill_in('Address', with: options.fetch(:address, ''))
    fill_in('Email', with: options.fetch(:email, ''))
    click_button('Create Order')
  end

  def has_validation_messages?
    has_css?('.alert-error')
  end

  def visit_page
    visit '/orders/new'
  end
end
