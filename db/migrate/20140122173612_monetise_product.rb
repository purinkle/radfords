class MonetiseProduct < ActiveRecord::Migration
  def up
    remove_column :products, :price
    add_money :products, :price
  end

  def down
    remove_money :products, :price
    add_column :products, :price, :string, precision: 8, scale: 2
  end
end
