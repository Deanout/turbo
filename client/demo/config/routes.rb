Rails.application.routes.draw do

  # update_counter is a custom action
  get 'update_counter', to: 'pages#update_counter', as: 'update_counter'

  root 'pages#home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
