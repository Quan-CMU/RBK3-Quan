Rails.application.routes.draw do
  get    '/microposts',to:'microposts#micropost'
  get    '/action',   to: 'contact#action'
  get    '/help',     to: 'static_pages#help'
  get    '/about',    to: 'static_pages#about'
  get    '/signup',   to: 'users#new'
  get    '/login',    to:'sessions#new'
  post   '/login',    to:'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  root to: 'static_pages#home'
  resources :microposts, only: %i[create destroy]
  resources :users #only: %i[show new create edit delete update index destroy]  
  resources :account_activations, only: %i[edit]
end

