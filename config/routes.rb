Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about', as: :about
  get 'getting-started-with-vim', to: 'static_pages#getting_started_with_vim', as: :getting_started_with_vim
  get 'learning-vim', to: 'static_pages#learning_vim', as: :learning_vim
  get 'questions', to: 'questions#index'

  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :destroy, :new]

  resources :questions, only: [:index, :create, :new, :show] do
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

