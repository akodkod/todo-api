Rails.application.routes.draw do
  resources :todos, except: [:new, :edit]
  resources :users, except: [:new, :edit, :destroy] do
    collection do
      post :login
    end
  end
end
