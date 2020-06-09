Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  get '/404', to: "errors#not_found"
  get '/422', to: "errors#unacceptable"
  get '/500', to: "errors#internal_error"

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  root 'static_pages#home'
  devise_for :users, skip: :omniauth_callbacks,  controllers: { registrations: 'registrations' }

    resource :password, only: [:edit], module: :users do
      collection do
        patch 'update_password'
      end
    end

    resources :boards do

      get 'cards/new' => 'cards#new'
      post 'cards' => 'cards#create'
      get 'cards/:id' => 'cards#show', as: 'card'
      get 'cards' => 'cards#index'
      get 'cards/:id/edit' => 'cards#edit', as: 'cards_edit'
      patch 'cards/:id'=> 'cards#update'
      delete 'cards/:id' => 'cards#destroy'
      patch 'cards/:id/update_confidence' => 'cards#update_confidence', as: 'card_update_confidence'
      patch 'cards/:id/update_confidence_from_learning' => 'boards#update_confidence_from_learning',
      as: 'card_update_confidence_from_learning'
      member do
        get 'learning'
        get 'learning_random'
        get 'mark_down'
        get 'mark_up'
      end

    end

    get 'imports/new' => 'imports#new'
    post 'imports' => 'imports#create'
    get 'imports' => 'imports#index'
    patch 'imports/:id' => 'imports#update'
    get 'imports/:id' => 'imports#show'
    delete 'imports/:id' => 'imports#destroy'

    resources :quizzes do
      get 'quiz_questions/new' => 'quiz_questions#new'
      post 'quiz_questions' => 'quiz_questions#create'
      get 'quiz_questions/:id' => 'quiz_questions#show', as: 'quiz_question'
      get 'quiz_questions' => 'quiz_questions#index'
      get 'quiz_questions/:id/edit' => 'quiz_questions#edit', as: 'quiz_questions_edit'
      patch 'quiz_questions/:id'=> 'quiz_questions#update'
      delete 'quiz_questions/:id' => 'quiz_questions#destroy'
    end

    resources :avatars, except: [:show, :edit, :update]
  end
end
