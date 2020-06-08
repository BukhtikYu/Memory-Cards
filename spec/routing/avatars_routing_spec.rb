# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AvatarsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/avatars').to route_to('avatars#index')
    end

    it 'routes to #new' do
      expect(get: '/avatars/new').to route_to('avatars#new')
    end

    it 'routes to #create' do
      expect(post: '/avatars').to route_to('avatars#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/avatars/1').to route_to('avatars#destroy', id: '1')
    end
  end
end
