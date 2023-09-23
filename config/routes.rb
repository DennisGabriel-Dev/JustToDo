Rails.application.routes.draw do
  resources :tasks
  resources :task_lists
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "task_lists#index"
end
