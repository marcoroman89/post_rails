PostRails::Application.routes.draw do
  root 'pages#home'
    get 'about' => 'pages#about'

  resources :posts
  resources :categories, only: [:new, :create, :show]  

end
