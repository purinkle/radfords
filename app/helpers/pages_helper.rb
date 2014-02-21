module PagesHelper
  def product_button(product)
    if signed_in?
      render(partial: 'product_button', locals: {product: product})
    end
  end
end
