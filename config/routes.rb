RetentionfactoryEngine::Application.routes.draw do
  root 'application#index'

  devise_for :users, :controllers => {:sessions => 'sessions', :registrations=>'registrations'} #override the default devise controller with our own in app/controllers/sessions_controller

  namespace :api do
    namespace :v1 do
      resources :orders, only: :create
    end
  end
end
