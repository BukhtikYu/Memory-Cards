Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    devise_for :users
    root 'static_pages#home'
    resources :boards do

      get 'cards/new' => 'cards#new'
      post 'cards' => 'cards#create'
      get 'cards/:id' => 'cards#show', as: 'card'
      get 'cards' => 'cards#index'
      get 'cards/:id/edit' => 'cards#edit', as: 'cards_edit'
      patch 'cards/:id'=> 'cards#update'
      delete 'cards/:id' => 'cards#destroy'
    end
    get '*unmatched' => 'static_pages#not_found'
  end
end
