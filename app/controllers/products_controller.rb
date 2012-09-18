class ProductsController < ApplicationController
  before_filter :authenticate, except: :show

  def create
    @product = Product.new(params[:product])

    if @product.save
      flash[:success] = 'You successfully created a new product.'
      redirect_to(@product)
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

  def index; end

  def new
    @title = 'New Product'
    @product = Product.new
  end

  def show
    @product = ProductDecorator.find(params[:id])
    @title = @product.title
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      flash[:success] = 'Product was successfully updated.'
      redirect_to(@product)
    else
      @title = 'Edit Product'
      render action: 'edit'
    end
  end

  def check_title
    product = Product.find_by_title(params[:product][:title])
    is_valid = !product
    id = params[:product][:id]

    if product && !id.blank? && product == Product.find(id)
      is_valid = true
    end

    render json: is_valid
  end

  private
    def authenticate
      deny_access unless signed_in?
    end
end
