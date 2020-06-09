# frozen_string_literal: true

class Import < ApplicationRecord
  has_one_attached :file
  belongs_to :user
  validates :file, presence: true, size: { less_than: 2.megabytes, message: 'should be less than 2Mb' }
end
