Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: %i[index show new create edit update destroy]
  resources :suppliers, only: %i[index show new create edit update]
  resources :product_models, only: %i[index show new create]

  resources :orders, only: %i[index new create show] do
    get 'search', on: :collection
  end
end
