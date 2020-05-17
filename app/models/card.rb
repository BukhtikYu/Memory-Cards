# frozen_string_literal: true

class Card < ApplicationRecord
  validates :question, presence: true
  belongs_to :user

  def author
    user
  end
end
