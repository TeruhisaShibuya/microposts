Rails.application.routes.draw do
  get 'sessions/new'

  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do   #まずは一覧ページへのアクションをuserへ追加 userのコントローラーへメソッド×2個記入する
    member do
      get :following_index, :followers_index
    end
  end
  
  #これにより作られるルーティングは?  get(verb)  users/1/following_index  following_index_user_path(1) 
  
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end