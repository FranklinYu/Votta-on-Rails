# frozen_string_literal: true

Rails.application.routes.draw do
  resources :candidates, except: [:index, :create] do
    member do
      post 'vote-up'
      delete 'vote-up', to: 'candidates#cancel_up_vote'
    end
  end
  resources :topics do
    resources :candidates, only: [:index, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions, except: :show
  resource :user
end
