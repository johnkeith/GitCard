Rails.application.routes.draw do
  root to: 'home#index'

  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile

  get '/auth/github/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: :signout
end
