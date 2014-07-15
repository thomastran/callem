Rails.application.routes.draw do
  resources :contacts

  root to: 'contacts#index'
  devise_for :users
  resources :users
end
