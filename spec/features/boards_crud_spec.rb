# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Boards', type: :feature do
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

      it 'adds one more board' do
        visit '/en/boards/new'
        fill_in id: 'board_name', with: 'SECONDBOARD'
        click_button('Submit')
        expect(page).to have_text('TESTBOARD')
        expect(page).to have_text('SECONDBOARD')
      end

      it 'opens the board' do
        visit '/en/boards'
        click_link 'TESTBOARD'
        expect(page.html).to include('<h2>TESTBOARD</h2>')
      end

      it 'edits board name' do
        visit '/en/boards'
        click_link 'Edit'
        fill_in id: 'board_name', with: 'TESTEDITED'
        click_button('submit')
        expect(page).to have_text('TESTEDITED')
      end

      it 'deletes board' do
        visit '/en/boards'
        click_link 'Destroy'
        page.driver.browser.switch_to.alert.accept if Capybara.current_driver == :chrome
        expect(page).not_to have_text('testBoard')
      end
    end
  end
end
