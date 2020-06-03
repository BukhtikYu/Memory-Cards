# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Boards', type: :request do
  let(:board) { FactoryBot.create(:board) }
  let(:user) { FactoryBot.create(:user) }

  context 'when signed in' do
    before do
      post '/users/sign_in', params: { user: { email: user.email,
                                               password: user.password } }
    end

    it 'renders boards page' do
      get '/boards'
      expect(response).to have_http_status(:ok)
    end

    it 'renders boards indedx' do
      get '/boards/:id'
      expect(response).to have_http_status(:found)

      follow_redirect!
      expect(response).to have_http_status(:ok)
    end

    it 'renders new board page' do
      get '/boards/new/'
      expect(response).to render_template(:new)

      post '/boards', params: { board: { name: board.name,
                                         user: board.user } }

      expect(response).to have_http_status(:found)

      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Board was successfully created')
    end

    it 'renders edit board page' do
      get '/boards/:id/edit'
      expect(response).to have_http_status(:found)

      follow_redirect!
      expect(response).to have_http_status(:ok)
    end
  end
end
