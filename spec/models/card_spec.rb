# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card, type: :model do
  subject { described_class.new(card_params) }

  let(:card_params) do
    {
      question: 'What is Ruby?'
    }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:board) }
  end

  describe 'validations' do
    it { is_expected.to  validate_presence_of(:question) }
  end
end
