Rails.application.routes.draw do
  resources :orders, only: [:create, :show] do
    collection do
      get :price
      post :accept
    end
  end
  resources :drivers, only: [:show] do
    resources :orders, only: [:index, :show]
  end

end
