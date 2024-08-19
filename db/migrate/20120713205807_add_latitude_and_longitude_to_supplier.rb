class AddLatitudeAndLongitudeToSupplier < ActiveRecord::Migration[4.2]
  def change
    add_column :suppliers, :latitude, :float
    add_column :suppliers, :longitude, :float
  end
end
