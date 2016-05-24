class NewProductPage
  include FactoryGirl::Syntax::Methods
  include Capybara::DSL
  include Rails.application.routes.url_helpers
  include Formulaic::Dsl

  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def create_product
    VCR.use_cassette("aws", match_requests_on: [:host]) do
      fill_form(:product, product)
      click_on(submit(:product))
    end
  end

  def has_error?(text)
    page.has_text?(text)
  end

  def has_flash?(text)
    page.has_text?(text)
  end

  def new_product_page?
    page.has_title?("New Product")
  end

  def product_page?
    page.has_title?(product_title)
  end

  def visit
    super(new_product_path)
  end

  private

  def product
    attributes_for(:product).merge(options)
  end

  def product_title
    product.fetch(:title)
  end
end
