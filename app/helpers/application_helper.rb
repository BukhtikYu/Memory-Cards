# frozen_string_literal: true

module ApplicationHelper
  def avatar_for(user)
    if user.avatars.order(updated_at: :desc).first&.image
      image_tag(rails_blob_path(user.avatars.order(updated_at: :desc).first.image), size: 40, style: 'border-radius: 50%', align: 'center')
    elsif user.avatar_link.blank?
      image_tag('default-image.jpg', size: 40, style: 'border-radius: 50%', align: 'center')
    else
      image_tag(user.avatar_link, size: 40, style: 'border-radius: 50%', align: 'center')
    end
  end

  def show_name(user)
    user.username.presence || user.email
  end
end
