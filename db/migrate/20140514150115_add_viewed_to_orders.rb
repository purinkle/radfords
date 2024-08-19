class AddViewedToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :viewed, :boolean, null: false, default: false
  end
end
