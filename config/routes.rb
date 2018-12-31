Rails.application.routes.draw do
  devise_for :users
  # TODO: Move to /users/settings?
  resource   :preferences, only: %i[show update]

  resources :groups
  resources :subscriptions, only: %i[index create destroy]
  resources :activities do
    post 'approve'
  end
  resources :assignments, only: %i[index create destroy]

  root 'welcome#index'
end
