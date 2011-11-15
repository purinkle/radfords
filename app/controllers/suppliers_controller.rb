class SuppliersController < ApplicationController
  def new
    @supplier = Supplier.new
  end
end