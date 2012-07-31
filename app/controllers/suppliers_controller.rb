class SuppliersController < ApplicationController
  before_filter :authenticate

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    redirect_to outlets_path, flash: {
      success: 'The supplier was destroyed successfully.'
    }
  end

  def new
    @supplier = Supplier.new
    @title = 'New Supplier'
  end

  def create
    @supplier = Supplier.new(params[:supplier])

    if @supplier.save
      redirect_to outlets_path, flash: {
        success: 'The supplier was created successfully.'
      }
    else
      @title = 'New Supplier'

      render 'new'
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
    @title = @supplier.name
  end

  def edit
    @supplier = Supplier.find(params[:id])
    @title = 'Edit Supplier'
  end

  def update
    @supplier = Supplier.find(params[:id])

    if @supplier.update_attributes(params[:supplier])
      redirect_to outlets_path, flash: {
        success: 'The supplier was updated successfully.'
      }
    else
      @title = 'Edit Supplier'

      render 'edit'
    end
  end

  private
    def authenticate
      deny_access unless signed_in?
    end
end
