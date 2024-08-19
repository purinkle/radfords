class ChangeDatatypesOnOrdersFromStringToText < ActiveRecord::Migration[4.2]
  def up
    change_column :orders, :email, :text, limit: nil
    change_column :orders, :name, :text, limit: nil
  end

  def down
    change_column :orders, :email, :string
    change_column :orders, :name, :string
  end
end
