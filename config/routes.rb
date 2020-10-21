Rails.application.routes.draw do
  root 'transactions#index'

  resources :transactions, only: %i[index create]
end
