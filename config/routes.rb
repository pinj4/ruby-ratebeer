Rails.application.routes.draw do
  resources :users
  resources :beers
  resources :breweries

  root 'breweries#index'

  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to:'ratings#new'
  # post 'ratings', to: 'ratings#create'
  resources :ratings, only: %i[index new create destroy]
  resource :session, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new'

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
end
