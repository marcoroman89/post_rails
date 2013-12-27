PostRails::Application.routes.draw do
  root "pages#home"
    get "about" => "pages#about"

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end  


  
  resources :categories, only: [:new, :create, :show]  
end
