class ProductPage
  include Capybara::DSL

  def has_image?
    has_xpath?("//img[contains(@src, \"#{url}\")]")
  end

  private

  def product
    Product.last
  end

  def url
    product.photo.url(:show)
  end
end
