class ProductsController < ApplicationController
  skip_before_action :authenticate, only: :show

  def index
    @products = Product.all
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
    @product.save!
    redirect_to(@product, notice: t("products.create"))
  rescue ActiveRecord::RecordInvalid
    render "new"
  end

  def delete
    @product = product
  end

  def update
    @product = Product.friendly.find(params[:id])

    flash[:notice] = "Product saved."
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render "edit"
    end
  end

  def destroy
    begin
      @product = Product.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to products_url, alert: t(".alert")
      return
    end

    if @product.destroy
      redirect_to products_url, notice: t(".notice")
    else
      render :delete
    end
  end

  private

  def product
    Product.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "We couldn't find that product."
    redirect_to products_path
  end

  def product_params
    params.require(:product).permit(
      :description,
      :photo,
      :title
    )
  end
end
