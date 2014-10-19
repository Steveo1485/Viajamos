Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :users, only: [:show]

  get 'planner' => 'planner#index', as: :user_root
  get 'planner' => 'planner#index', as: :planner

  root 'pages#home'
end
