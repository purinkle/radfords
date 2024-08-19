class MonetiseProduct < ActiveRecord::Migration[4.2]
  def up
    remove_column :products, :price
    add_monetize :products, :price
  end

  def down
    remove_money :products, :price
    add_column :products, :price, :string, precision: 8, scale: 2
  end
end
