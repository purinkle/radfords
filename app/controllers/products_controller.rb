class ProductsController < ApplicationController
  skip_before_action :authenticate, only: :show
  before_action :find_product, only: %i[show edit delete update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :product_not_found

  def index
    @products = Product.with_attached_photo
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    create_and_show(@product)
  end

  def delete; end

  def update
    update_and_show(@product, product_params)
  end

  def destroy
    if @product.destroy
      redirect_to products_url, notice: t(".notice")
    else
      render :delete
    end
  end

  private

  def find_product
    @product = Product.with_attached_photo.friendly.find(params[:id])
  end

  def product_not_found
    redirect_to products_path, alert: t("products.not_found")
  end

  def product_params
    params.require(:product).permit(:description, :photo, :title)
  end
end
