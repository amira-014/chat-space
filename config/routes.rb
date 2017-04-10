Rails.application.routes.draw do
  root 'groups#index'

  resources :groups, only: [:get] do
    resources :messages
  end
end
