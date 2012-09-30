class ProductsController < ApplicationController
  def index; end

  def new
    @product = Product.new
  end
end
