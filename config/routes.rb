Rails.application.routes.draw do
  resources :styles
  resources :beer_clubs
  resources :memberships
  resources :users do
    post 'toggle_lock', on: :member
  end

  resource :session, only: [:new, :create, :destroy]
  get 'beerlist', to:'beers#list'
  get 'brewerylist', to:'breweries#list'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'

  get 'ngbrewerylist', to:'breweries#nglist'

  delete 'signout', to: 'sessions#destroy'

  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :ratings, only: [:index, :new, :create, :destroy]

  resources :places, only:[:index, :show]
  post 'places', to:'places#search'

  root 'breweries#index'

end
