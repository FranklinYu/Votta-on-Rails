# frozen_string_literal: true

Rails.application.routes.draw do
  resources :candidates
  resources :topics
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions, except: :show
  resource :user
end
