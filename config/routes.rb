TypicalAndTemporary::Application.routes.draw do
  root 'splash#index'

  devise_for :users, :controllers => {:sessions => 'sessions', :registrations=>'registrations'} #override the default devise controller with our own in app/controllers/sessions_controller

  get 'oauth_callback' => 'story#oauth_callback'
  
  get 'thank_you' => 'story#thank_you'
  post 'authorize' => 'story#authorize'
  
end
