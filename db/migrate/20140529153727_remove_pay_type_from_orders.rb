class RemovePayTypeFromOrders < ActiveRecord::Migration[4.2]
  def up
    remove_column :orders, :pay_type
  end

  def down
    add_column :orders, :pay_type, :string
  end
end
