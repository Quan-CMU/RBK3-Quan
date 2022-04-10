Rails.application.routes.draw do
  get    'micropost/micropost'
  get    '/action',   to: 'contact#action'
  get    '/help',     to: 'static_pages#help'
  get    '/about',    to: 'static_pages#about'
  get    '/signup',   to: 'users#new'
  get    '/login',    to:'sessions#new'
  post   '/login',    to:'sessions#create'
  delete    '/logout',   to: 'sessions#destroy'
  root "static_pages#home"
  resources :micropost
  resources :users, only: %i[show new create edit delete update index] 
end

