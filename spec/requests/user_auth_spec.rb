# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User auth', type: :request do
  let(:user) { FactoryBot.create(:user, email: 'newtest@gmail.com') }

  it 'renders log in page' do
    get '/users/sign_in'
    expect(response).to have_http_status(:ok)
    expect(response.body).to include('Log in')
  end

  it 'successfully log in' do
    post '/users/sign_in', params: { user: { email: user.email,
                                             password: '123456' } }

    expect(response).to have_http_status(:found)
    follow_redirect!

    expect(response.body).to include('Signed in successfully.')
  end

  it 'renders sign up page' do
    get '/users/sign_up'
    expect(response).to have_http_status(:ok)
    expect(response.body).to include('Sign up')
  end

  it 'renders edit page' do
    get '/users/edit'
    expect(response).to have_http_status(:found)
  end
end
