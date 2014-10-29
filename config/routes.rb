Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :friendships, only: [:create, :destroy] do
    post 'accept', on: :member
    patch 'block', on: :member
  end
  resources :users, only: [:show]

  post 'find_friends' => 'friendships#find_friends', as: :find_friends
  get 'planner' => 'planner#index', as: :user_root
  get 'planner' => 'planner#index', as: :planner

  root 'pages#home'
end
