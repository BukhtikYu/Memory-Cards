# frozen_string_literal: true

json.extract! quiz, :id, :name, :user, :created_at, :updated_at
json.url quiz_url(quiz, format: :json)
