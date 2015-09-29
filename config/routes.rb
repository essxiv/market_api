MarketApi::Application.routes.draw do
  # API Definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    # List Resources
  end

end