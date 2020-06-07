# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true
  validates :username, uniqueness: { allow_blank: true }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :google_oauth2]
  has_many :boards, dependent: :destroy
  has_many :imports, dependent: :destroy
  has_many :quizzes, dependent: :destroy

  # rubocop:disable Metrics/AbcSize
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email || "#{auth.info.nickname}@gmail.com"
      user.avatar_link = auth.info.image
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
      user.password = Devise.friendly_token[0, 20]
    end
  end
  # rubocop:enable Metrics/AbcSize
end
