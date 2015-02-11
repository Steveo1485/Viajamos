Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :facebook_connections, only: [:update]
  resources :favorite_locations, only: [:new, :create, :destroy]
  resources :friendships, only: [:create, :update, :destroy]

  resources :locations, only: [] do
    get 'search', on: :collection
  end

  resources :trips
  resources :users, only: [:show, :edit, :update]

  get 'planner' => 'planner#index', as: :user_root
  get 'planner' => 'planner#index', as: :planner

  root 'pages#home'
end
