# encoding: utf-8
class MessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality

  def auth
    render :text => params[:echostr]
  end

  def talk
    if params[:xml] and params[:xml][:MsgType] == "text"
      render "reply", :formats => :xml
    end
    render "reply", formats: :xml
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    token = YAML.load(File.read(File.join(Rails.root,"config/weixin.yml")))["token"]
    array = [token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end

