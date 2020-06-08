# frozen_string_literal: true

require 'rails_helper'
require 'confidence_counter'

RSpec.describe ConfidenceCounter do
  context 'when board has cards with different confidence_levels' do
    let(:board) { FactoryBot.create :board }
    let(:card_marked_very_bad) { FactoryBot.create :card, board_id: board.id, confidence_level: 1 }
    let(:card_marked_perfect) { FactoryBot.create :card, board_id: board.id, confidence_level: 5 }
    let(:card_marked_undefined) { FactoryBot.create :card, board_id: board.id, confidence_level: 0 }
    subject(:counter) { ConfidenceCounter.new(board) }
    
    before do
      card_marked_undefined
      card_marked_very_bad
      card_marked_perfect
    end
    
    it 'counter get marks from board' do
      expect(counter.all_marks).to include(0,1,5)
    end
    
    it 'counter return value of board confidence' do
      expect(counter.count_board_confidence).to eq(40)
    end
  end
  
  context 'when board has one card with undefined value' do
    let(:board) { FactoryBot.create :board }
    let(:card_marked_undefined) { FactoryBot.create :card, board_id: board.id, confidence_level: 0 }
    subject(:counter) { ConfidenceCounter.new(board) }
    
    before do
      card_marked_undefined
    end

    it 'counter return 0' do
      expect(counter.count_board_confidence).to eq(0)
    end
  end

  context 'when board has no cards' do
    let(:board) { FactoryBot.create :board }
    subject(:counter) { ConfidenceCounter.new(board) }

    it 'counter return 0' do
      expect(counter.count_board_confidence).to eq(0)
    end
  end
end
