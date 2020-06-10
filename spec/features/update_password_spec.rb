# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Update password', type: :feature do
  let(:user) { FactoryBot.create :user }

  before do
    log_in(user)
    visit '/en/users/edit'
    click_link 'Change your password'
  end

  context 'when user fill correct password' do
    it 'returns success message on root page' do
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button('Update User')

      expect(page).to have_text('Welcome to Memory Cards')
      expect(page).to have_current_path '/en'
    end
  end

  context 'when new password empty' do
    it "returns error message with: Password can't be blank" do
      click_button('Update User')

      expect(page).to have_text("Password can't be blank")
      expect(page).to have_text('1 error prohibited this user from being saved')
    end
  end

  context 'when password confirmation empty' do
    it "returns error message with: Password confirmation doesn't match Password" do
      fill_in 'user_password', with: 'password'
      click_button('Update User')

      expect(page).to have_text('1 error prohibited this user from being saved')
      expect(page).to have_text("Password confirmation doesn't match Password")
    end
  end

  context 'when password does not match with password confirmation' do
    it "returns error message: Password confirmation doesn't match Password" do
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'user password'
      click_button('Update User')

      expect(page).to have_text("Password confirmation doesn't match Password")
      expect(page).to have_text('1 error prohibited this user from being saved')
    end
  end
end
