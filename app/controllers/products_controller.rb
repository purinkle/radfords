class ProductsController < ApplicationController
  def index
    @title = 'Products'
  end

  def new
    @title = 'New product'
  end
end
