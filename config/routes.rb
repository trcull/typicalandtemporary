TypicalAndTemporary::Application.routes.draw do
  root 'splash#index'

  devise_for :users, :controllers => {:sessions => 'sessions', :registrations=>'registrations'} #override the default devise controller with our own in app/controllers/sessions_controller

end
