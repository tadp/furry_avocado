Rails.application.routes.draw do
  root to: "static_pages#home"
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :destroy, :new]

  resources :questions, only: [:create, :new, :show] do
    member do
      post :create_vote
      post :create_tags
      delete :destroy_tag
    end

    resources :responses, only: [:create, :destroy] do
      member do
        post :create_vote
      end
    end
  end

  resources :tags, only: [:show]
end

