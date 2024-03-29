Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers, :dmRoom
    end
  end
  root 'posts#index' 
  resources :messages, only: [:create]
  resources :rooms, only: [:new, :create, :show, :index, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, except: :show
  get   'users/:id'   =>  'users#show'

  resources :notifications, only: :index
  
end
