Rails.application.routes.draw do
  resources :session_suggestions
  resources :busy_times
  resources :calendar_times
  resources :preferred_times
  resources :places
  resources :users
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "busy_times#show"
end
