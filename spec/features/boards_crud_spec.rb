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
        fill_in id: 'board_name', with: 'testBoard'
        click_button('Submit')
      end

      it 'adds one more board' do
        visit '/en/boards/new'
        fill_in id: 'board_name', with: 'secondBoard'
        click_button('Submit')
        expect(page).to have_text('testBoard')
        expect(page).to have_text('secondBoard')
      end

      it 'opens the board' do
        visit '/en/boards'
        click_link 'testBoard'
        expect(page.html).to include('<h2>testBoard</h2>')
      end

      it 'edits board name' do
        visit '/en/boards'
        click_link 'Edit'
        fill_in id: 'board_name', with: 'testEdited'
        click_button('Update Board')
        expect(page).to have_text('testEdited')
      end

      it 'deletes board' do
        visit '/en/boards'
        click_link 'Destroy'
        expect(page).not_to have_text('testBoard')
      end
    end
  end
end
