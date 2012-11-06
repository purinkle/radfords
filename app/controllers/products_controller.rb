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

  def edit
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "We couldn't find that product."
    redirect_to products_path
  end

  def index; end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      flash[:notice] = 'Product saved.'
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end
end
