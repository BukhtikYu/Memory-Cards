# frozen_string_literal: true

json.extract! avatar, :id, :created_at, :updated_at
json.url avatar_url(avatar, format: :json)
