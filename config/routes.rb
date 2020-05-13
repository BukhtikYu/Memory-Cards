Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
 
  get 'cards/new' => 'cards#new'
  post 'cards' => 'cards#create'
  get 'cards/:id' => 'cards#show', as: 'card'
  get 'cards' => 'cards#index'
  get 'cards/:id/edit' => 'cards#edit', as: 'cards_edit'
  patch 'cards/:id'=> 'cards#update'
  delete 'cards/:id' => 'cards#destroy'
end
