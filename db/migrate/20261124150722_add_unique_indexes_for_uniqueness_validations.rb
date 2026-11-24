# Product and User validate uniqueness, but only in Ruby, so two requests
# that land together can both pass the check and both save. A unique index
# makes the database refuse the second.
class AddUniqueIndexesForUniquenessValidations < ActiveRecord::Migration[6.1]
  def change
    add_index :products, :title, unique: true
    add_index :users, :email, unique: true
  end
end
