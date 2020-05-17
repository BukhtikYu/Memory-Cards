class AddCardToBoards < ActiveRecord::Migration[6.0]
  def change
  	add_reference :cards, :board
  end
end
