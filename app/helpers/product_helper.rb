module ProductHelper
  def product_list(products)
    partial = 'product_list'

    if products.empty?
      partial = 'no_products'
    end

    partial
  end
end
