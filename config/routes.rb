Rails.application.routes.draw do
  get 'posts/create'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get "/home", to: 'users#home'
  get "/profile", to: 'users#profile'
  get "/users/:id/profile", to: 'users#profile'
  get "/profile/:option", to: 'users#profile'
  patch "/profile/update_description", to: 'users#update_profile_description'
  post "/profile/update_avatar", to: 'users#update_avatar'
  root "users#home"
  resources :posts, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  post "/user_friend/request_friend", to: "user_friend#request_friend"
  post "/user_friend/accept_friend", to: "user_friend#accept_friend"
  post "/user_friend/reject_friend", to: "user_friend#reject_friend"
  post "/user_friend/remove_friend", to: "user_friend#remove_friend"
  resources :likes, only: [:create]
  post "/likes/destroy", to: "likes#destroy"
end
