require 'api_constraints'

MarketApi::Application.routes.draw do
  # API Definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do

    scope module: :v1, constraints: ApiConstraints.new(verison: 1, default: true) do
      # List Resources

    end
  end
end