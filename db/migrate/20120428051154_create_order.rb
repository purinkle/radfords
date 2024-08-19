class CreateOrder < ActiveRecord::Migration[4.2]
  def self.up
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
