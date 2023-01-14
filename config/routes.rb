require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  namespace :api, defaults: { format: :json } do
    resources :users, only: %w[show] do
      member do
        post 'create_project', to: 'users#create_project'
        get 'task_assigned', to: 'users#task_assigned'
        get 'projects_created', to: 'users#projects_created'
      end
      collection do
        post '/create_task', to: 'users#create_task'
        post '/assign_task', to: 'users#assign_task'
      end
    end
  end

  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: 'api/login',
               sign_out: 'api/logout',
               registration: 'api/signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
end
