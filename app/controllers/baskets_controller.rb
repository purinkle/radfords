class BasketsController < ApplicationController
  def show
    @basket = Basket.find(params[:id])
    @title = 'Basket'
  end
end
