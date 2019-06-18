Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get 'users/:twitterid' => 'users#home'
  get 'move' => 'pages#move'
  resources :users
  resources :posts
end
