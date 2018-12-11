Rails.application.routes.draw do
  devise_for :users

  resources :groups
  resources :subscriptions
  resources :activities
  resources :assignments

  root 'welcome#index'
end
