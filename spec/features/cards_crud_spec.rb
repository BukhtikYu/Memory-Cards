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
        fill_in id: 'board_name', with: 'TESTBOARD'
        click_button('Submit')
      end

      context 'when user created new card' do
        before do
          visit '/en/boards'
          click_link 'TESTBOARD'
          click_link 'New card'
          fill_in id: 'card_question', with: 'TESTQUESTION'
          fill_in id: 'card_answer', with: 'TESTANSWER'
          click_button('Submit')
        end

        it 'adds one more card' do
          visit '/en/boards'
          click_link 'TESTBOARD'
          click_link 'New card'
          fill_in id: 'card_question', with: 'SECONDTESTQUESTION'
          fill_in id: 'card_answer', with: 'SECONDTESTANSWER'
          click_button('Submit')
          expect(page).to have_text('TESTQUESTION')
          expect(page).to have_text('TESTANSWER')
          expect(page).to have_text('SECONDTESTQUESTION')
          expect(page).to have_text('SECONDTESTANSWER')
        end

        it 'opens card' do
          visit '/en/boards'
          click_link 'TESTBOARD'
          click_link 'Show'
          expect(page).to have_text('TESTQUESTION')
          click_button 'SHOW'
          expect(page).to have_text('TESTANSWER')
        end

        it 'edits question and answer in card' do
          visit '/en/boards'
          click_link 'TESTBOARD'
          click_link 'Update'
          fill_in id: 'card_question', with: 'QUESTIONEDITED'
          fill_in id: 'card_answer', with: 'ANSWEREDITED'
          click_button('submit')
          expect(page).to have_text('QUESTIONEDITED')
          screenshot_and_save_page
          expect(page).to have_text('ANSWEREDITED')
        end

        it 'deletes card' do
          visit '/en/boards'
          click_link 'Destroy'
          page.driver.browser.switch_to.alert.accept if Capybara.current_driver == :chrome
          expect(page).not_to have_text('TESTBOARD')
        end
      end
    end
  end
end
