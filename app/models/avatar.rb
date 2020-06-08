# frozen_string_literal: true

class Avatar < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :image, presence: true
  validate :acceptable_image_size?
  validate :count_avatars

  private

  def acceptable_image_size?
    return unless image.byte_size > 200.kilobytes

    errors.add :avatar, 'is over 200KB'
  end

  def count_avatars
    return unless user.avatars.count > 2

    errors.add :avatar, 'to match avatars'
  end
end
