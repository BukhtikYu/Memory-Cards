# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Edit profile', type: :feature do
  let(:user) { FactoryBot.create :user }

  before do
    log_in(user)
    visit '/en/users/edit'
  end

  context 'when user change email' do
    it 'returns success message on root page' do
      fill_in 'user_email', with: 'new.email@test.com'
      click_button('Update')

      expect(page).to have_text('Your account has been updated successfully')
      expect(page).to have_current_path '/en'
    end
  end

  context 'when user delete email' do
    it 'returns error message' do
      find(:xpath, ".//input[@id='user_email']").set('')
      click_button('Update')

      expect(page).to have_text("Email can't be blank")
      expect(page).to have_text('1 error prohibited this user from being saved')
    end
  end

  context 'when user detele account' do
    it 'returns success message on root page' do
      click_button('Delete account')
      page.driver.browser.switch_to.alert.accept if Capybara.current_driver == :chrome

      expect(page).to have_text('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
    end
  end
end
