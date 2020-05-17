class AddForeignKeyBoardToCard < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :cards, :boards
  end
end
