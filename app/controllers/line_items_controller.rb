class LineItemsController < ApplicationController
  skip_before_filter :authenticate

  def create
    @basket = current_basket
    @basket.add_product(product.id).save
    redirect_to basket_url
  end

  def destroy
    item.destroy
    redirect_to basket_url
  end

  def update
    item.update_attributes item_params
    redirect_to basket_url
  end

  private

  def id
    params.fetch :id
  end

  def item
    LineItem.find id
  end

  def item_params
    params.require(:line_item).permit :quantity
  end

  def product
    Product.find(product_id)
  end

  def product_id
    params[:product_id]
  end
end
