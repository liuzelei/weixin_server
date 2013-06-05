class DemoWeixin::Router
  def initialize(type="text")
    @message_type = type
  end

  def matches?(request)
    xml_data = request.params[:xml]
    if xml_data and xml_data.is_a?(Hash)
      @message_type == request.params[:xml][:MsgType]
    end
  end
end

DemoWeixin::Application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users

  get "welcome/index"
  get "welcome/test"
  post "welcome/test1"

  get "message/io" => "welcome#auth"
  scope "/", via: :post do
    #match "message/io" => "message#input_text", constraints: lambda {|request| request.params[:xml].nil? }
    #match "message/io" => "message#input_image", constraints: lambda {|request| request.params[:xml] && request.params[:xml][:MsgType] == "text"}
    match "message/io" => "message#input_text", constraints: DemoWeixin::Router.new("text")
    match "message/io" => "message#input_image", constraints: DemoWeixin::Router.new("image")
    match "message/io" => "message#input_location", constraints: DemoWeixin::Router.new("location")
    match "message/io" => "message#input_link", constraints: DemoWeixin::Router.new("link")
    match "message/io" => "message#input_event", constraints: DemoWeixin::Router.new("event")
    match "message/io" => "message#input_music", constraints: DemoWeixin::Router.new("music")
    match "message/io" => "message#input_news", constraints: DemoWeixin::Router.new("news")
    match "message/io" => "message#input_others"
    #match "message/io" => "message#input_text", constraints: lambda {|r| r.params}
  end

  resources :weixin_users do
    member do
      get "messages"
    end
  end
  resources :shops
  resources :settings
  resources :qa_steps
  resources :keyword_replies
  resources :news do
    resources :items
    collection do
      get "list"
    end
  end
  resources :activities
  resources :coupons do
    collection  do
      get :search
    end
  end

  resources :statistics, only: [:index] do
    collection do
      get "chart_messages"
      get "chart_messages_add_up"
      get "chart_follows"
      get "chart_follows_add_up"
      match 'detail', via: [:get, :post]#, :as => :search
      match 'detail_export', via: [:get, :post]#, :as => :search
      #get "detail_export"
      get "follows"
      get "follows_export"
      get "msg_types"
      get "dates"
      get "weixin_users"
      get "weixin_users_dates"
      get "keywords"
    end
  end
  resources :articles do
    member do
      get "pres"
    end
  end
  resources :pictures
  resources :audios
  resources :videos

  get "others/djq"

  #root to: 'welcome#index'
  #root to: 'statistics#index'
  root to: 'statistics#chart_messages'

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
