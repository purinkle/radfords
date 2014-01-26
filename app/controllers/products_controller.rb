class ProductsController < ApplicationController
  skip_before_filter :authenticate, only: :show

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

  def destroy
    begin
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to products_url, alert: t('products.destroy.alert')
      return
    end

    if @product.destroy
      redirect_to products_url, notice: t('products.destroy.notice')
    else
      render :delete
    end
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

    if @product.update_attributes(product_params)
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

  def product_params
    params.require(:product).permit(
      :description,
      :photo,
      :photo_file_name,
      :title
    )
  end
end
