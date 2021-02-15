Rails.application.routes.draw do
  get 'posts/create'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get "/home", to: 'users#home'
  root "users#home"
  resources :posts, only: [:create]
  resources :comments, only: [:create]
  post "/user_friend/request_friend", to: "user_friend#request_friend"
  post "/user_friend/accept_friend", to: "user_friend#accept_friend"
  post "/user_friend/reject_friend", to: "user_friend#reject_friend"
  post "/user_friend/remove_friend", to: "user_friend#remove_friend"
end
