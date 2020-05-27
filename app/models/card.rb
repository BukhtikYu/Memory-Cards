# frozen_string_literal: true

class Card < ApplicationRecord
  validates :question, presence: true

  belongs_to :user
  belongs_to :board

  def author
    user
  end

  enum confidence_level: {
    undefined: 0,
    very_bad: 1,
    bad: 2,
    medium: 3,
    good: 4,
    perfect: 5
  }
end
