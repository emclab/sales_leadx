SalesLeadx::Engine.routes.draw do
  
  resources :sales_leads, :only => [:index, :new, :create]
  resources :sales_leads do
    collection do
      get :search
      get :search_results      
      get :stats
      get :stats_results
    end          
  end  
  
  root :to => 'sales_leads#index'
end
