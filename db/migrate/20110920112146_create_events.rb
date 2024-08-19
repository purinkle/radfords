class CreateEvents < ActiveRecord::Migration[4.2]
  def self.up
    create_table :events do |t|
      t.string :name
      t.date :takes_place_on
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
