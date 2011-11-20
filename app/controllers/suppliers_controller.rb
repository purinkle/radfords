class SuppliersController < ApplicationController
  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(params[:supplier])

    if @supplier.save
      redirect_to @supplier
    else
      render 'new'
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
    @title = @supplier.name
  end

  def edit

  end
end