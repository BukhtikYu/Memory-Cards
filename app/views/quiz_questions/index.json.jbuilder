# frozen_string_literal: true

json.array! @quiz_questions, partial: 'quiz_questions/quiz_question', as: :quiz_question
