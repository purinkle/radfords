class AddOrderIdToBasket < ActiveRecord::Migration[4.2]
  def change
    add_column :baskets, :order_id, :integer
    add_index :baskets, :order_id
  end
end
