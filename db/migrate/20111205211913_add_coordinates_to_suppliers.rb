class AddCoordinatesToSuppliers < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :lat, :decimal, precision: 15, scale: 10
    add_column :suppliers, :lng, :decimal, precision: 15, scale: 10
  end

  def self.down
    remove_column :suppliers, :lat
    remove_column :suppliers, :lng
  end
end
