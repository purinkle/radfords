class NewOrderPage
  include Capybara::DSL
  include Formulaic::Dsl
  include RSpec::Matchers

  def create(options = {})
    fill_form(
      :order,
      address_line_1: '1 Test Street',
      address_line_2: 'Testerton',
      address_city: 'Testington',
      address_post_code: 'TE5 7TE',
      address_county: 'Testshire',
      email: options.fetch(:email, ''),
      name: options.fetch(:name, '')
    )

    VCR.use_cassette('create stripe charge') do
      click_button('Create Order')
    end
  end

  def has_validation_messages?
    has_css?('.alert-error')
  end

  def visit_page
    visit '/orders/new'
  end
end
