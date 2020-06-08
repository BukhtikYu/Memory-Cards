# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locale', type: :feature do
  let(:user) { FactoryBot.create :user }

  context 'when user is guest' do
    context 'when user change locale from en to ru on root' do
      it 'returns page in Russian language' do
        visit '/en'
        click_link 'hamburger'
        click_link 'Rus'
        expect(page).to have_text('ЛОГОТИП')
        expect(page).to have_current_path '/ru'
      end
    end
  end

  context 'when user signed' do
    before { log_in(user) }

    context 'when user create new board with Russian locale ' do
      it 'returns pages in russian language' do
        visit '/ru/boards/new'
        fill_in id: 'board_name', with: 'Тестовый борд'
        click_button('Создать борд')

        expect(page).to have_text('Борд создан успешно')
      end
    end

    context 'when user create new board with English locale' do
      it 'returns pages in english language' do
        visit '/en/boards/new'
        fill_in id: 'board_name', with: 'Test board'
        click_button('Submit')

        expect(page).to have_text('Board was successfully created')
      end
    end

    context 'when user edits profile with Russian locale' do
      it 'returns pages in russian language' do
        visit '/ru/users/edit'
        fill_in 'user_username', with: 'Тестовое имя'
        click_button('Обновить')

        expect(page).to have_text('Ваша учетная запись была успешно обновлена')
      end
    end

    context 'when user edits profile with English locale' do
      it 'returns pages in english language' do
        visit '/en/users/edit'
        fill_in 'user_username', with: 'name'
        click_button('Update')

        expect(page).to have_text('Your account has been updated successfully')
      end
    end
  end
end
