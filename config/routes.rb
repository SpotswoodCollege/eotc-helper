Rails.application.routes.draw do
  devise_for :users
  # TODO: Move to /users/settings?
  resource   :preferences, only: %i[show update]

  resources :groups
  resources :subscriptions
  resources :activities
  resources :assignments

  root 'welcome#index'
end
