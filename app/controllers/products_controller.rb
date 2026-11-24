class ProductsController < ApplicationController
  skip_before_action :authenticate, only: :show

  def index
    @products = Product.with_attached_photo
  end

  def show
    @product = product
  end

  def new
    @product = Product.new
  end

  def edit
    @product = product
  end

  def create
    @product = Product.new(product_params)
    create_and_show(@product)
  end

  def delete
    @product = product
  end

  def update
    @product = find_product

    if @product.update(product_params)
      redirect_to product_path(@product), notice: t(".notice")
    else
      render "edit"
    end
  end

  def destroy
    @product = find_product

    if @product.destroy
      redirect_to products_url, notice: t(".notice")
    else
      render :delete
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to products_url, alert: t(".alert")
  end

  private

  def product
    find_product
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t("products.destroy.alert")
    redirect_to products_path
  end

  def find_product
    Product.with_attached_photo.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :description,
      :photo,
      :title
    )
  end
end
