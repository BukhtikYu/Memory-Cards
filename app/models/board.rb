# frozen_string_literal: true

class Board < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 250 }
  has_many :cards, dependent: :destroy
end
