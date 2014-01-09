class DeleteProductPage
  include Capybara::DSL
  include RSpec::Matchers

  def delete
    VCR.use_cassette('delete product', match_requests_on: [:host]) do
      click_button('Delete Product')
    end
  end

  def has_line_item_error?
    has_css?('.alert-error li', text: 'Line Items present')
  end

  def visit_page(product)
    visit("/products/#{product.id}/delete")
  end
end
