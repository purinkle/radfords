module PagesHelper
  def product_button(product)
    render(partial: "shared/product_button", locals: { product: product })
  end

  def render_basket(basket)
    unless basket.line_items.empty?
      render(basket)
    end
  end
end
