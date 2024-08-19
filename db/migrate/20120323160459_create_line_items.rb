class CreateLineItems < ActiveRecord::Migration[4.2]
  def self.up
    create_table(:line_items) do |t|
      t.integer(:product_id)
      t.integer(:basket_id)
      t.timestamps
    end
  end

  def self.down
    drop_table(:line_items)
  end
end
