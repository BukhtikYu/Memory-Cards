# frozen_string_literal: true

class Card < ApplicationRecord
  validates :question, presence: true, length: { maximum: 65_000 }
  validates :answer, presence: true, length: { maximum: 65_000 }

  belongs_to :board

  enum confidence_level: {
    undefined: 0,
    very_bad: 1,
    bad: 2,
    medium: 3,
    good: 4,
    perfect: 5
  }

  acts_as_list scope: :board

  def self.to_csv
    attributes = %w[board_name question answer]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.find_each do |card|
        csv << attributes.map { |attr| card.send(attr) }
      end
    end
  end

  def board_name
    self.board.name
  end
end
