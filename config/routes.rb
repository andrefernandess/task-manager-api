require 'api_version_constraint'

Rails.application.routes.draw do
  #sobrescreve os parametros do devise, para implementar apenas os methodos de session e serem aplicados no controller sessions criado e nao no controller padrao do devise
  devise_for :users, only: [:sessions], controllers: { sessions: 'api/v1/sessions' }
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api'}, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :tasks, only: [:index]
    end
  end
end
