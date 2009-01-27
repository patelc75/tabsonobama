ActionController::Routing::Routes.draw do |map|
  # Restful Authentication Rewrites
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.change_password '/change_password/:reset_code', :controller => 'passwords', :action => 'reset'
  map.open_id_complete '/opensession', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.open_id_create '/opencreate', :controller => "users", :action => "create", :requirements => { :method => :get }
    
  # Restful Authentication Resources
  map.resources :splashes
  map.resources :weekly_radio_addresses
  map.resources :cabinet_members
  map.resources :users
  map.resources :passwords	
  map.resource :session
  map.resources :promotions, :only => [:create, :destroy]
  map.resources :ratings, :only => :index
  map.resources :issue_groups, :as => :campaign_promise_groups
  map.resources :issue_sections, :as => :campaign_promise_sections
  map.resources :issue_bullets, :as => :campaign_promise_bullets
  
  # Custom routes for cabinet, weekly, and campaign promises
  map.connect 'campaign-promises', :controller => "issue_groups"
  map.connect 'campaign-promises/:id', :controller => "issue_groups", :action => "show"
  map.connect 'campaign-promises/:ig/:id', :controller => "issue_bullets", :action => "show"
  map.connect 'weekly-radio-addresses', :controller => "weekly_radio_addresses"
  map.connect 'weekly-radio-addresses/:id', :controller => "weekly_radio_addresses", :action => "show"
  map.connect 'cabinet-members', :controller => "cabinet_members"
  map.connect 'cabinet-members/:id', :controller => "cabinet_members", :action => "show"

  #don't need nested routes
  #map.resources :issue_groups, :as => :campaign_promises do |groups|
  #  groups.resources :issue_sections, :as => :campaign_sections do |sections|
  #    sections.resources :issue_bullets, :as => :campaign_bullets
  #  end
  #end

  # Home Page
  map.root :controller => APP_CONFIG[:root_controller], :action => 'index'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
