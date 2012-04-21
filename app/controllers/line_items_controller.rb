class LineItemsController < ApplicationController
  def create
    @basket = current_basket
    product = Product.find(params[:product_id])
    @line_item = @basket.add_product(product.id)
    @line_item.save
    redirect_to(products_path)
  end
end
