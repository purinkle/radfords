class BasketsController < ApplicationController
  def destroy
    @basket = current_basket
    @basket.destroy
    session[:basket_id] = nil
    redirect_to(products_path)
  end

  def show
    begin
      @basket = Basket.find(params[:id])
      @title = 'Basket'
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid basket #{params[:id]}")
      flash[:error] = 'Invalid basket.'
      redirect_to(products_path)
    end
  end
end
