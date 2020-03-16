Rails.application.routes.draw do
  devise_for :users,controllers: { registrations: 'users/registrations' }
  resources :users ,only: [:show,:update, :edit]
  get 'mypages/index'
  # たすけてえええええええええええええええええええええええええ
  get 'posts/index'
  root 'posts#index'
  get 'posts/search'
  resources :posts,only: [:create, :new, :show, :destroy] do
  	resources :likes, only: [:create, :destroy]
  end

  resources :comments do
    resources :commentlikes, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
