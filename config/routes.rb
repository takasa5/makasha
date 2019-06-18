Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get 'users/:twitterid' => 'users#home'
  get 'record/move' => 'pages#move'
  get 'record/edit' => 'pages#edit'
  patch 'record/edit/:id' => 'posts#update'
  resources :users
  resources :posts
end
