class AddLatitudeAndLongitudeToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :latitude, :float
    add_column :suppliers, :longitude, :float
  end
end
