class ProductsController < ApplicationController
  def create
    @product = Product.new(params[:product])
    @product.save
    render 'new'
  end

  def index; end

  def new
    @product = Product.new
  end
end
