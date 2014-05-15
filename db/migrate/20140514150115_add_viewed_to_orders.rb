class AddViewedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :viewed, :boolean, null: false, default: false
  end
end
