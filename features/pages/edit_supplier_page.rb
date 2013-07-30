class EditSupplierPage
  include Capybara::DSL
  include Capybara::Node::Matchers
  include RSpec::Matchers

  def initialize(name = nil, address = nil, phone_number = nil, website = nil)
    @name = name
    @address = address
    @phone_number = phone_number
    @website = website
  end

  def update
    fill_in "Name", with: name
    fill_in "Address", with: address
    fill_in "Telephone number", with: phone_number
    fill_in "Website", with: website

    VCR.use_cassette("update supplier") do
      click_button "Update"
    end
  end

  private

  attr_reader :address, :name, :phone_number, :website
end
