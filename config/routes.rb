require 'sidekiq/web'

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :people, only: [:index, :show]
    end
  end
  mount Sidekiq::Web => "/sidekiq"
end
