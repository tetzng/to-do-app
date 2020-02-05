Rails.application.routes.draw do
  resources :tasks, only: [:index, :new, :create, :show, :edit, :update]
end
