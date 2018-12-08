Rails.application.routes.draw do
  devise_for :users

  resources :groups
  resources :subscriptions
  resources :activities

  root 'welcome#index'
end
