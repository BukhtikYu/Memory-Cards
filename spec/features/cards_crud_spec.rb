# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cards', type: :feature do
  let(:user) { FactoryBot.create :user }

  context 'when user logged in' do
    before do
      visit 'en/users/sign_in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button('Log in')
    end

    context 'when user created new board' do
      before do
        visit '/en/boards/new'
        fill_in id: 'board_name', with: 'testBoard'
        click_button('Submit')
      end

      context 'when user created new card' do
        before do
          visit '/en/boards'
          click_link 'testBoard'
          click_link 'New card'
          fill_in id: 'card_question', with: 'testQuestion'
          fill_in id: 'card_answer', with: 'testAnswer'
          click_button('Submit')
        end

        it 'adds one more card' do
          visit '/en/boards'
          click_link 'testBoard'
          click_link 'New card'
          fill_in id: 'card_question', with: 'secondTestQuestion'
          fill_in id: 'card_answer', with: 'secondTestAnswer'
          click_button('Submit')
          expect(page).to have_text('testQuestion')
          expect(page).to have_text('testAnswer')
          expect(page).to have_text('secondTestQuestion')
          expect(page).to have_text('secondTestAnswer')
        end

        it 'opens card' do
          visit '/en/boards'
          click_link 'testBoard'
          click_link 'Show'
          expect(page).to have_text('testQuestion')
          expect(page).to have_text('testAnswer')
        end

        it 'edits question and answer in card' do
          visit '/en/boards'
          click_link 'testBoard'
          click_link 'Edit'
          fill_in id: 'card_question', with: 'questionEdited'
          fill_in id: 'card_answer', with: 'answerEdited'
          click_button('Submit')
          expect(page).to have_text('questionEdited')
          expect(page).to have_text('answerEdited')
        end

        it 'deletes card' do
          visit '/en/boards'
          click_link 'Destroy'
          expect(page).not_to have_text('testBoard')
        end
      end
    end
  end
end
