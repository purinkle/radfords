class ProductsController < ApplicationController
  def create
    redirect_to(Product.create(params[:product]))
  end

  def index
    @title = 'Products'
  end

  def new
    @title = 'New product'
    @product = Product.new
  end

  def show
    @title = Product.find(params[:id]).title
  end
end
