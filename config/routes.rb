Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get    '/settings',       to: 'users#show'
  get    '/signup',         to: 'users#new'
  delete '/delete_account', to: 'users#destroy'

  resources :users
end
