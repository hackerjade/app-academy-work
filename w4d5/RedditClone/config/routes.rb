Rails.application.routes.draw do
  resources :users
  resource :session
  resources :subs
  resources :posts, only: [:new,:edit]
  resources :posts, only: [:create,:update, :show]
  resources :comments, only: [:new, :create]
end
