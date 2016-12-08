Rails.application.routes.draw do
  resources :orders, only: [:create, :show] do
    collection do
      get :price
    end
  end
  resources :drivers, only: [:show, :update] do
    resources :orders, only: [:index, :show]
  end
end
