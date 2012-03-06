class ProductsController < ApplicationController
  def create
    @product = Product.new(params[:product])

    if @product.save
      flash[:success] = 'You successfully created a new product.'
      redirect_to(Product.create(params[:product]))
    else
      @title = 'New Product'
      render 'new'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = 'You successfully deleted the product.'
    redirect_to(products_path)
  end

  def edit
    @title = 'Edit Product'
    @product = Product.find(params[:id])
  end

  def index
    @title = 'Products'
    @products = Product.all
  end

  def new
    @title = 'New Product'
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
    @title = @product.title
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])
    redirect_to(@product)
  end
end
