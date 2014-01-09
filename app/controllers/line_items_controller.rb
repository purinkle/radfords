class LineItemsController < ApplicationController
  skip_before_filter :authenticate

  def create
    @basket = current_basket
    @basket.add_product(product.id).save
    redirect_to @basket
  end

  private

  def product
    Product.find(product_id)
  end

  def product_id
    params[:product_id]
  end
end
