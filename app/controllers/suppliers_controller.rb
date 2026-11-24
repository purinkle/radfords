class SuppliersController < ApplicationController
  def new
    @supplier = Supplier.new
  end

  def edit
    @supplier = supplier
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @supplier.save!
    redirect_to(outlets_path, notice: t(".notice"))
  rescue ActiveRecord::RecordInvalid
    render "new"
  end

  def update
    @supplier = supplier
    @supplier.update!(supplier_params)
    redirect_to(outlets_path, notice: t("suppliers.update"))
  rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  def destroy
    supplier.destroy
    redirect_to(outlets_path, notice: t(".notice"))
  end

  private

  def supplier
    Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(
      :address,
      :latitude,
      :longitude,
      :name,
      :telephone_number,
      :website
    )
  end
end
