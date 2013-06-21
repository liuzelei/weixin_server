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
  resources :settings

  get "welcome/index"
  get "welcome/test"
  post "welcome/test1"

  get "message/:user_id" => "welcome#auth", as: :message_api
  scope "/", via: :post do
    #match "message/:user_id" => "message#input_text", constraints: lambda {|request| request.params[:xml].nil? }
    #match "message/:user_id" => "message#input_image", constraints: lambda {|request| request.params[:xml] && request.params[:xml][:MsgType] == "text"}
    match "message/:user_id" => "message#input_text", as: :message_api, constraints: DemoWeixin::Router.new("text")
    match "message/:user_id" => "message#input_image", as: :message_api, constraints: DemoWeixin::Router.new("image")
    match "message/:user_id" => "message#input_location", as: :message_api, constraints: DemoWeixin::Router.new("location")
    match "message/:user_id" => "message#input_link", as: :message_api, constraints: DemoWeixin::Router.new("link")
    match "message/:user_id" => "message#input_event", as: :message_api, constraints: DemoWeixin::Router.new("event")
    match "message/:user_id" => "message#input_music", as: :message_api, constraints: DemoWeixin::Router.new("music")
    match "message/:user_id" => "message#input_news", as: :message_api, constraints: DemoWeixin::Router.new("news")
    match "message/:user_id" => "message#input_others", as: :message_api
    #match "message/:user_id" => "message#input_text", constraints: lambda {|r| r.params}
  end

  resources :weixin_users do
    member do
      get "messages"
    end
  end

  resources :keyword_replies
  resources :qa_steps
  resources :news do
    resources :items
    collection do
      get "list"
    end
  end

  resources :event_types, only: [:index]
  namespace :hd do
    resources :ggks do
      resources :ggk_histories, only: [:show, :index]
    end
    resources :dzps do
      resources :dzp_histories, only: [:index, :show]
    end
  end
  resources :service_types, only: [:index]
  namespace :fw do
    resources :baidu_maps do
      member do
        get "serve"
      end
    end
  end
  resources :activities
  resources :coupons do
    collection  do
      get :search
    end
  end

  resources :articles do
    member do
      get "pres"
    end
  end
  resources :reply_texts
  resources :audios
  resources :pictures
  resources :videos

  resources :shops
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
      get "weixin_users_cnt_dates"
      get "weixin_users_dates"
      get "keywords"
    end
  end

  resource :others, only: [:index] do
    collection do
      get :djq
      get :scratch_card
    end
  end

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
