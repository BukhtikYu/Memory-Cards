# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  it 'respond with 404 if page not found' do
    get '/404'
    expect(response).to have_http_status(:not_found)
  end

  it 'respond with 422 if page unacceptable' do
    get '/422'
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'respond with 500 if page have internal error' do
    get '/500'
    expect(response).to have_http_status(:error)
  end
end
