Rails.application.routes.draw do
  resources :channels
  resources :users
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'channels#index'
end
