Rails.application.routes.draw do
  devise_for :users
  root to: "projects#index"

  resources :projects, :defaults => {format: :json} do
    resources :tasks, :defaults => {format: :json}
  end

end
