Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  get '/404', to: "errors#not_found"
  get '/422', to: "errors#unacceptable"
  get '/500', to: "errors#internal_error"

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  devise_for :users, skip: :omniauth_callbacks

    resource :password, only: [:edit], module: :users do
      collection do
        patch 'update_password'
      end
    end
    root 'static_pages#home'
    resources :boards do

      get 'cards/new' => 'cards#new'
      post 'cards' => 'cards#create'
      get 'cards/:id' => 'cards#show', as: 'card'
      get 'cards' => 'cards#index'
      get 'cards/:id/edit' => 'cards#edit', as: 'cards_edit'
      patch 'cards/:id'=> 'cards#update'
      delete 'cards/:id' => 'cards#destroy'
      member do
        get 'learning'
      end
    end
  end
end
