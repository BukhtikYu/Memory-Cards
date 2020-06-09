# frozen_string_literal: true

class QuizQuestion < ApplicationRecord
  validates :question, presence: true, length: { maximum: 250 }

  belongs_to :quiz
end
