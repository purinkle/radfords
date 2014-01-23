class SuppliersController < ApplicationController
  def destroy
    supplier.destroy
    redirect_to(outlets_path, notice: "You successfully deleted the supplier.")
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @supplier.save!
    redirect_to(outlets_path, notice: "You successfully created a supplier.")
  rescue ActiveRecord::RecordInvalid
    render "new"
  end

  def edit
    @supplier = supplier
  end

  def update
    @supplier = supplier
    @supplier.update_attributes!(supplier_params)
    redirect_to(outlets_path, notice: t("suppliers.update"))
  rescue ActiveRecord::RecordInvalid
    render 'edit'
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
