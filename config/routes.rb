Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  resources :contacts do
    collection do
    end
    member do
      post 'call', :action => 'call'
    end
  end

end
