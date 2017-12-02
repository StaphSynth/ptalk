Rails.application.routes.draw do
  resources :channels
  resources :users
  resources :messages
  root to: 'channels#index'

  mount ActionCable.server => '/cable'
end
