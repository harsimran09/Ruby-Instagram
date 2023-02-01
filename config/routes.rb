Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'
  # Defines the root path route ("/")
  # root "articles#index"
  # resources :users, only: [:show]
  # resources :users, only: [:show, :edit, :update]
  # resources :posts, only: [:new, :create, :show, :destroy]
  resources :users
  resources :follows, only: [:create, :destroy]
  resources :posts do
    resources :comments
  end
  resources :users do
    member do
      get :followers, :followings, :given_follows, :received_follows
    end
  end
  resources :users do
    member do
      patch :follow
    end
  end
end
