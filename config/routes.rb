Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :destroy, :new]
  resources :questions, only: [:create, :new, :show] do
    member do
      post :vote
      post :create_tags
      delete :destroy_tag_assignment
    end
  end
  resources :votes, only: [:create]
  resources :tags, only: [:show]
  resources :tag_assignments, only: [:create, :destroy]
end
