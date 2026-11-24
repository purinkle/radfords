class LineItemsController < ApplicationController
  skip_before_action :authenticate

  def create
    product = Product.friendly.find(params[:product_id])
    current_basket.add_product(product.id).save
    redirect_to basket_url
  end

  def update
    item.update(params.require(:line_item).permit(:quantity))
    redirect_to basket_url
  end

  def destroy
    item.destroy
    redirect_to basket_url
  end

  private

  def item
    LineItem.find(params[:id])
  end
end
