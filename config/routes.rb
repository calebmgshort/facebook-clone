Rails.application.routes.draw do
  get 'posts/create'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get "/home", to: 'users#home'
  root "users#home"
  resources :posts, only: [:create]
  resources :comments, only: [:create]
end
