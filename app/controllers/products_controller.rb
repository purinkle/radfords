class ProductsController < ApplicationController
  skip_before_filter :authenticate, only: :show

  def create
    @product = Product.new(params[:product])
    @product.save!
    redirect_to(@product, notice: t("products.create"))
  rescue ActiveRecord::RecordInvalid
    render "new"
  end

  def delete
    @product = product
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_url, notice: 'Product was deleted.'
  end

  def edit
    @product = product
  end

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def show
    @product = product
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

  private

  def product
    Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "We couldn't find that product."
    redirect_to products_path
  end
end
