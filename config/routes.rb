Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :destroy, :new]
  resources :questions, only: [:create, :new, :show]
  resources :votes, only: [:create]
  resources :tags, only: [:create]
  resources :tag_assignments, only: [:create, :destroy]
end
