Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show] do
    resources :comments, only: [:new, :create]
  end

  resource :session, only: [:new, :create, :destroy]

  resources :goals, except: [:index, :new, :show] do
    resources :comments, only: [:new, :create]
  end

end
