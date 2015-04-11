class NewOrderPage
  include Capybara::DSL
  include Formulaic::Dsl
  include RSpec::Matchers

  def create(options = {})
    fill_form(
      :order,
      "Address" => "1 Test Street",
      "Apt, suite, etc." => "Testerton",
      "City" => "Testington",
      "Postal code" => "TE5 7TE",
      "County" => "Testshire",
      "Email" => options.fetch(:email, ""),
      "Name" => options.fetch(:name, "")
    )

    VCR.use_cassette('create stripe charge') do
      click_button("Place my order")
    end
  end

  def has_validation_messages?
    has_css?('.alert-error')
  end

  def visit_page
    visit '/orders/new'
  end
end
