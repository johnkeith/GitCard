Rails.application.routes.draw do
  root to: 'home#index'
  
  resources :repos, only: [:edit, :update]

  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile
  post ':username/edit', to: 'repos#toggle_visbility', as: :toggle_visbility

  get '/auth/github/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: :signout
end
