class AddForeignKeyToCard < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :cards, :users
  end
end
