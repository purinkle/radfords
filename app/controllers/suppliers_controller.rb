class SuppliersController < ApplicationController
  def new
    @supplier = Supplier.new
    @title = 'New supplier'
  end

  def create
    @supplier = Supplier.new(params[:supplier])

    if @supplier.save
      redirect_to @supplier
    else
      @title = 'New supplier'

      render 'new'
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
    @title = @supplier.name
  end

  def edit
    @title = 'Edit supplier'
  end
end