class ProductsController < ApplicationController
  def create
    @product = Product.new(params[:product])
    
    if @product.save
      redirect_to product_path(@product.id), flash: {
        success: 'The product was created successfully.'
      }
    else
      render 'new'
    end
  end

  def edit; end

  def index; end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end
end
