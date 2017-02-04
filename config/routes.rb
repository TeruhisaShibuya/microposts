Rails.application.routes.draw do
  get 'sessions/new'

  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

   resources :users do
    member do
      get :followings, :followers
    end
  end
  
  #これにより作られるルーティングは?  get(verb)  users/1/following  following_user_path(1) 
  
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end