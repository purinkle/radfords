module PagesHelper
  def product_button(product)
    render(partial: "shared/product_button", locals: { product: product })
  end
end
