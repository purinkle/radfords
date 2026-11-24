class ChangeDatatypesOnOrdersFromStringToText < ActiveRecord::Migration[4.2]
  def up
    change_table :orders, bulk: true do |t|
      t.change :email, :text, limit: nil
      t.change :name, :text, limit: nil
    end
  end

  def down
    change_table :orders, bulk: true do |t|
      t.change :email, :string
      t.change :name, :string
    end
  end
end
