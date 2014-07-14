Rails.application.routes.draw do
  root to: 'home#index'
  
  resources :repos, only: [:edit, :update]
  resources :users, only: [:edit, :update]

  get '/auth/github', as: :create_account
  get '/auth/github/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: :signout

  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile
  post ':username/edit', to: 'repos#toggle_visbility', as: :toggle_visbility

  get ':username/refresh', to: 'profiles#refresh', as: :refresh_profile

end
