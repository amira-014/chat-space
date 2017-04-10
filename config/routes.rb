Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'

  resources :groups, only: [:get] do
    resources :messages
  end
end
