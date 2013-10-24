RetentionfactoryEngine::Application.routes.draw do
  root 'splash#index'

  devise_for :users, :controllers => {:sessions => 'sessions', :registrations=>'registrations'} #override the default devise controller with our own in app/controllers/sessions_controller

  namespace :api do
    namespace :v1 do
      resources :orders, only: :create
      get 'rollups/:organization_id/order_counts_by_customer_age'=> 'rollups#order_counts_by_customer_age'
      get 'rollups/:organization_id/order_count_histogram'=> 'rollups#order_count_histogram'
      get 'rollups/:organization_id/age_at_repeat_order_histogram'=> 'rollups#age_at_repeat_order_histogram'
      get 'rollups/index' => 'rollups#index'
    end
  end
  
  get 'dashboard' => 'dashboard#index'
  
  namespace :ecomm do
    get 'recent_repeat_purchases' => 'repeat_purchases#recent_repeat_purchases'
    get 'repeat_purchase_ages' => 'repeat_purchases#repeat_purchase_ages'
    get 'repeat_purchase_rates' => 'repeat_purchases#repeat_purchase_rates'
    get 'top_purchase_sequences' => 'repeat_purchases#top_purchase_sequences'
  end
end
