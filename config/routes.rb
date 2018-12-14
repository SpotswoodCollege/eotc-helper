Rails.application.routes.draw do
  devise_for :users

  resources :groups
  resources :subscriptions

  root 'welcome#index'
end
