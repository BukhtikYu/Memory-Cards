# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Passwords', type: :request do
  it 'renders update password page' do
    get '/users/sign_in'
    expect(response).to have_http_status(:ok)
  end
end
