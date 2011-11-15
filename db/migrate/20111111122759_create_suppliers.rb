class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string 'address'
      t.string 'name'
      t.string 'telephone_number'
      t.string 'website'

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
