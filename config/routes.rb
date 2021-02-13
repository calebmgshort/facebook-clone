Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get "/home", to: 'users#home'
  root "users#home"
end
