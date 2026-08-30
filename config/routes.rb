Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :toggle
    end
  end
  resources :task_lists do
    member do
      patch :reorder
    end
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "task_lists#index"
end
