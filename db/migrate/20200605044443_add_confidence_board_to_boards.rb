class AddConfidenceBoardToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :confidence_board, :int
  end
end
