PostRails::Application.routes.draw do
  root "pages#home"
    get "about" => "pages#about"

  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:show, :create, :edit, :update]

  resources :posts do
    member do
      post "vote" # /post/1/anyaction
    end  
    resources :comments, only: [:create, :destroy] do
      member do
        post "vote"
      end  
    end  
  end  

  resources :categories, only: [:new, :create, :show]  
end
