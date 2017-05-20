Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :users do
    collection do
      get 'search'
    end
  end
  resources :groups do
    resources :messages, module: 'groups'
  end

end
