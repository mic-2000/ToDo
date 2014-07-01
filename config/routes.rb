Rails.application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions'}
  root to: "home#index"

  resources :projects, :defaults => {format: :json} do
    resources :tasks, :defaults => {format: :json} do
      post 'sort', on: :collection
    end
  end

  resources :comments, :defaults => {format: :json}, only: [:index, :create, :destroy]

end
