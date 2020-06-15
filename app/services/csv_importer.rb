# frozen_string_literal: true
  require 'csv'

class CsvImporter

  def initialize(import: ,user:)
    @user = user
    @import = import
    @csv_file = @import.file.download
  end

  def card_create
    CSV.parse(@csv_file, headers: true) do |row|
      @board = Board.find_or_initialize_by(name: row['board_name'])
      @board.user_id = @user.id
      @board.save
      @card = @board.cards.build(question: row['card_question'], answer: row['card_answer'])
      @card.save
    end
  end

end
