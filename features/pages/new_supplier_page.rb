class NewSupplierPage
  include Capybara::DSL
  include Capybara::Node::Matchers
  include RSpec::Matchers

  def initialize(name = nil, address = nil, phone_number = nil)
    @name = name
    @address = address
    @phone_number = phone_number
  end

  def create
    fill_in "Name", with: name
    fill_in "Address", with: address
    fill_in "Telephone number", with: phone_number

    VCR.use_cassette("create supplier") do
      click_button "Create Supplier"
    end
  end

  private

  attr_reader :name, :address, :phone_number
end
