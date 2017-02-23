Rails.application.routes.draw do
  get '/search', to: 'search#index'

  root 'site#index'
end
