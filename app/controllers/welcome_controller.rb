class WelcomeController < ApplicationController
  include Weixin::Plugins
  include WeixinUsersHelper

  skip_before_filter :authenticate_user!#, only: [:auth]
  skip_before_filter :verify_authenticity_token, only: [:auth]

  def index
  end

  def auth
    render :text => params[:echostr]
  end

  def test
    #WeixinWeb.delay.steal_weixin_user_info
    detect_current_user
    render :test_template, format: :html, locals: {abc: "bcd"}
  end

  def test1
    render text: "just test"
  end

end
