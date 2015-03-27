Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :destroy, :new]
  resources :questions, only: [:create, :new, :show] do
    resources :votes, only: [:create]
    resources :tags, only: [:create, :destroy]
    resources :responses, only: [:create, :destroy] do
      resources :votes, only: [:create]
    end
  end
  resources :tags, only: [:show]
end

