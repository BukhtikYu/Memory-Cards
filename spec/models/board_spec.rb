# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  subject { described_class.new(board_params) }

  let(:board_params) do
    {
      name: 'Ruby'
    }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to  have_many(:cards) }
  end

  describe 'validations' do
    it { is_expected.to  validate_presence_of(:name) }
    it { is_expected.to  validate_length_of(:name).is_at_most(250) }
  end
end
