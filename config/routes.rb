PostRails::Application.routes.draw do
  root "pages#home"
    get "about" => "pages#about"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"



  resources :posts do
    resources :comments, only: [:create, :destroy]
  end  

  resources :categories, only: [:new, :create, :show]  
end
