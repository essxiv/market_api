require 'api_constraints'

MarketApi::Application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # API Definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do

    scope module: :v1, constraints: ApiConstraints.new(verison: 1, default: true) do
      # List Resources
      resources :users, :only => [:show, :create, :update, :destroy] do
        resources :products, :only => [:create, :update, :destroy]
        resources :orders, :only => [:index, :show]
      end
      resources :sessions, :only => [:create, :destroy]
      resources :products, :only => [:show, :index]

    end
  end
end