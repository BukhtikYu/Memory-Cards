# frozen_string_literal: true

json.extract! quiz_question, :id, :question, :quiz_id, :created_at, :updated_at
json.url quiz_question_url(quiz_question, format: :json)
