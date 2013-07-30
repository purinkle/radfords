class NewProductPage
  include Capybara::DSL

  def create
    click_button "Create Product"
  end
end
