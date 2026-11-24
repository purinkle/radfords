class AddLatitudeAndLongitudeToSupplier < ActiveRecord::Migration[4.2]
  def change
    change_table :suppliers, bulk: true do |t|
      t.float :latitude
      t.float :longitude
    end
  end
end
