class ProductsController < ApplicationController
  def create
    redirect_to(Product.create(params[:product]))
  end

  def index
    @title = 'Products'
  end

  def new
    @title = 'New Product'
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
    @title = @product.title
  end
end
