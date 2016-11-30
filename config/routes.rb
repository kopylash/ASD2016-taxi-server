Rails.application.routes.draw do
  resources :orders, only: [:create, :show]

  resources :drivers, only: [:show] do
    resources :orders, only: [:index, :show]
  end

  post 'orders/accept', to: 'orders#accept'
end
