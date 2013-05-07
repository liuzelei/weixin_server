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

  get "welcome/index"

  get "stat/keywords"

  get "message/io"   => "message#auth"
  #post "message/io"  => "message#talk"
  scope "/", via: :post do
    #match "message/io" => "message#reply_text", constraints: lambda {|request| request.params[:xml].nil? }
    #match "message/io" => "message#reply_image", constraints: lambda {|request| request.params[:xml] && request.params[:xml][:MsgType] == "text"}
    match "message/io" => "message#reply_text", constraints: DemoWeixin::Router.new("text")
    match "message/io" => "message#reply_image", constraints: DemoWeixin::Router.new("image")
    match "message/io" => "message#reply_location", constraints: DemoWeixin::Router.new("location")
    match "message/io" => "message#reply_link", constraints: DemoWeixin::Router.new("link")
    match "message/io" => "message#reply_event", constraints: DemoWeixin::Router.new("event")
    match "message/io" => "message#reply_music", constraints: DemoWeixin::Router.new("music")
    match "message/io" => "message#reply_news", constraints: DemoWeixin::Router.new("news")
    match "message/io" => "message#reply_news", constraints: lambda {|r| r.params}
  end

  root to: 'welcome#index'

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
