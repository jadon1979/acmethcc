Rails.application.routes.draw do
  resources :orders
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :messages, only: [:create]

  # Defines the root path route ("/")
  root "orders#index"
end
