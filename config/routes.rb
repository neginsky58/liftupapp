Liftupv1::Application.routes.draw do
  # get "blogupdates/index"
  # get "blogupdates/create"
  # get "blogupdates/destroy"

  # get "newcomments/index"
  # get "newcomments/new"
  # get "user/show"
  # root :to => 'pages#home'
  # match 'users/:id', :to => 'users#destroy', :as => :destroy_user, :via => :delete

  get 'explore' => 'pages#explore'
  get 'projectlocationadmin' =>'projectlocations#admin'
  get 'categoryadmin' =>'categories#admin'
  get 'admin' => 'projects#admin'
  get 'projectstart' => 'pages#project_start_steps'
  get 'about' => 'pages#about'
  get 'privacypolicy' => 'pages#privacypolicy'
  get 'terms' => 'pages#terms'
  get 'faq' => 'pages#faq'
  match 'comments' => 'newcomments#admin'
  match 'commentstwo' => 'ttwocomments#admin'
  
  devise_for :users
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  # match 'users/:id' => 'users#show', as: :user
  match 'users/:permalink' => 'users#show', :as => "show_user"
  match 'users/:permalink/following' => 'users#following', :as => "following_user"
  match 'users/:permalink/followers' => 'users#followers', :as => "followers_user"
  match 'users/:permalink/comments' => 'users#comments', :as => "comments_user"
  match 'users/:permalink/activeprojects' => 'users#activeprojects', :as => "activeprojects_user"
  match 'users/:permalink/pendingprojects' => 'users#pendingprojects', :as => "pendingprojects_user"
  match 'users/:permalink/projectfollowing' => 'users#projectfollowing', :as => "projectfollowing_user"

  #match '/create_balanced_account', :to => 'balanced#create_balanced_account'
  #match '/store_credit_card', :to => 'balanced#store_credit_card'  
  #match '/donate_plan/project/:id', :to => 'donate_plans#project', :as => "project_donate_plans"
  match '/donate_plans/project/:id' => 'donate_plans#project', :as => "project_donate_plans"
  match '/donate_plans/save' => 'donate_plans#save', :as => "save_donate_plans"
  match '/donate_plans/delete/:donate_plan_id' => 'donate_plans#delete', :as => "delete_donate_plans"
  
  match '/donates/charge' => 'donates#charge', :as => "charge_donates"
  match '/donates/plan/:id' => 'donates#plan', :as => "plan_donates"
  
  resources :charges
  resources :categories
  resources :projectlocations
  
  resources :users
  
  # resources :users do
  #   member do
  #     get :following, :followers, :comments, :activeprojects, :pendingprojects, :projectfollowing
  #   end
  # end

  mount RedactorRails::Engine => '/redactor_rails'

  # match 'projects/:permalink' => 'projects#show', :as => "show_project"

  resources :projects do
    resources :newcomments 
    resources :blogupdates
    resources :review_comments
    resources :team_members
    resources :projectcosts
    member do
      get :following, :comments, :blogs, :team, :finances, :submitreview, :projectapproved, :returntouser, :editteam, :editcomments, :editprojectcosts
      put :submitreview, :projectapproved, :returntouser
    end   
  end

  resources :newcomments do
    resources :ttwocomments
  end
  resources :ttwocomments



  resources :blogupdates
  resources :team_members

  resources :creditcards, :path => 'creditcards' 
  resources :donates
  resources :donate_plans
  resources :accounts
  
  resources :projectcosts


  resources :relationships, only: [:create, :destroy]
  resources :project_relationships, only: [:create, :destroy]
  resources :bloglikes, only: [:create, :destroy]

  root :to => 'projects#index'

  match '/create_creditcard', :to => 'creditcards#create_creditcard', :as => :new_creditcards
  #match '/creditcards/:plan_id', :to => 'creditcards#index', :as => :creditcards
  match '/view_creditcards', :to => 'creditcards#view_creditcards', :as => :view_creditcards
  match '/save_creditcard', :to => 'creditcards#save_creditcard', :as => :save_creditcards 
  match '/stripe_callback', :to => 'accounts#stripe_callback', :as => :stripe_callback

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
