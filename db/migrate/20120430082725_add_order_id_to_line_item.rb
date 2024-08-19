class AddOrderIdToLineItem < ActiveRecord::Migration[4.2]
  def self.up
    add_column :line_items, :order_id, :integer
  end

  def self.down
    remove_column :line_items, :order_id
  end
end
