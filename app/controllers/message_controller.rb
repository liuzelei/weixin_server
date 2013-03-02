# encoding: utf-8
class MessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality, :save_request

  def auth
    render :text => params[:echostr]
  end

  def talk
    render "reply", formats: :xml
  end

  def reply_text
    render "text", formats: :xml
  end

  def reply_image
  end

  def reply_location
  end

  def reply_link
  end

  def reply_event
  end

  def reply_music
  end

  def reply_news
    render "news", formats: :xml
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    token = YAML.load(File.read(File.join(Rails.root,"config/weixin.yml")))["token"]
    array = [token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end

  # 保存数据到数据库
  def save_request
    RequestMessage.create \
      xml: params[:xml]
  end
end

