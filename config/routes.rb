Rails.application.routes.draw do
  get '/jobs/:id', to: 'jobs#show'

  get '/search/:id', to: 'search#show'

  get '/search', to: 'search#index'

  root 'site#index'
end
