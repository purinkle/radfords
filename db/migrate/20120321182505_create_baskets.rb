class CreateBaskets < ActiveRecord::Migration[4.2]
  def self.up
    create_table(:baskets, &:timestamps)
  end

  def self.down
    drop_table(:baskets)
  end
end
