Rails.application.routes.draw do
  devise_for :users,controllers: { registrations: 'users/registrations' }
  get 'users/:id/follow' => 'users#follow', as: :user_follow
  resources :users ,only: [:show,:update, :edit]
  get 'mypages/index'
  get 'posts/index'
  root 'posts#index'
  get 'posts/search'
  resources :posts,only: [:create, :new, :show, :destroy] do
  	resources :likes, only: [:create, :destroy]
    resources :retweets, only: [:create, :destroy]
  end
  resources :comments do
    resources :commentlikes, only: [:create, :destroy]
    resources :commentretweets, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
