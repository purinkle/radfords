class SuppliersController < ApplicationController
  before_action :find_supplier, only: %i[edit update destroy]

  def new
    @supplier = Supplier.new
  end

  def edit; end

  def create
    @supplier = Supplier.new(supplier_params)
    create_and_show(@supplier, outlets_path)
  end

  def update
    update_and_show(@supplier, supplier_params, outlets_path)
  end

  def destroy
    @supplier.destroy
    redirect_to(outlets_path, notice: t(".notice"))
  end

  private

  def find_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:address, :latitude, :longitude, :name, :telephone_number, :website)
  end
end
