# frozen_string_literal: true

class Card < ApplicationRecord
  validates :question, presence: true

  belongs_to :board

  enum confidence_level: {
    undefined: 0,
    very_bad: 1,
    bad: 2,
    medium: 3,
    good: 4,
    perfect: 5
  }
end
