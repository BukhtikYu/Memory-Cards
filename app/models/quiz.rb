# frozen_string_literal: true

class Quiz < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 250 }
  has_many :quiz_questions, dependent: :destroy
end
