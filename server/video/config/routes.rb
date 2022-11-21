Rails.application.routes.draw do
  root 'posts#index'

  # /posts/1/comments/3
  resources :posts do
    resources :comments
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
