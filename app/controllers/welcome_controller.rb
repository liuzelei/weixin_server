class WelcomeController < ApplicationController
  include Weixin::Plugins

  skip_before_filter :verify_authenticity_token, only: [:auth]

  def index
  end

  def auth
    render :text => params[:echostr]
  end

  def test
    WeixinWeb.delay.steal_weixin_user_info
    render :test_template, format: :html
  end

  def test1
    render text: "just test"
  end

end
