# frozen_string_literal: true

class ConfidenceCounter
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def all_marks
    @all_marks ||= board.cards.map(&:confidence_level_before_type_cast)
  end

  def count_board_confidence
    return 0 if all_marks.blank?

    all_marks.sum * 20 / all_marks.count.to_f
  end
end
