# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cards', type: :request do
  it 'renders cards page' do
    get '/boards/:id/cards'
    expect(response).to have_http_status(:found)

    follow_redirect!
    expect(response).to have_http_status(:ok)
  end

  it 'renders cards indedx' do
    get '/boards/:id/cards/:id'
    expect(response).to have_http_status(:found)

    follow_redirect!
    expect(response).to have_http_status(:ok)
  end

  it 'renders new cards page' do
    get '/boards/:id/cards/new/'
    expect(response).to have_http_status(:found)
    follow_redirect!

    expect(response).to have_http_status(:ok)
  end

  it 'renders edit card page' do
    get '/boards/:id/cards/:id/edit'
    expect(response).to have_http_status(:found)

    follow_redirect!
    expect(response).to have_http_status(:ok)
  end
end
