Rails.application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/auth/failure', to: redirect('/'), via: [:get, :post]

  get '/disclaimer' => 'countdowns#disclaimer', as: 'disclaimer'

  match '/new' => 'countdowns#new', as: 'new_countdown', via: [:get, :post]
  get '/:id' => 'countdowns#show', as: 'countdown'
  post '/' => 'countdowns#create', as: 'countdowns'
  match '/:id' => 'countdowns#update', via: [:patch, :put]
  delete '/:id/destroy' => 'countdowns#destroy'
  get '/:id/edit' => 'countdowns#edit', as: 'edit_countdown'

  root :to => 'countdowns#index'
end
