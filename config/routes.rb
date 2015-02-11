Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :facebook_connections, only: [:update]

  resources :favorite_locations, only: [:new, :create, :destroy]

  resources :friendships, only: [:create, :destroy] do
    post 'accept', on: :member
    patch 'block', on: :member
    patch 'facebook_request', on: :member
  end

  resources :locations, only: [] do
    get 'search', on: :collection
  end

  resources :trips
  resources :users, only: [:show, :edit, :update]

  post 'find_friends' => 'friendships#find_friends', as: :find_friends
  get 'planner' => 'planner#index', as: :user_root
  get 'planner' => 'planner#index', as: :planner

  root 'pages#home'
end
