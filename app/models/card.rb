# frozen_string_literal: true

class Card < ApplicationRecord
  validates :question, presence: true
end
