# encoding: utf-8
class MessageController < ApplicationController
  include Weixin::Plugins

  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality, :save_request

  def auth
    render :text => params[:echostr]
  end

  def talk
    render "reply", formats: :xml
  end

  def reply_text
    #per_page = params[:per_page].present? ? params[:per_page].to_i : 19
    req_content = params[:xml][:Content].to_s
    @content = \
      case req_content
      when "Hello2BizUser"
        "欢迎关注哦，输[文字]翻译，输[?文字]提问:)"
      when /^\?/
        "xxx"
      else
        translate_word req_content
      end

    render "text", formats: :xml
  end

  def reply_image
    render "reply", formats: :xml
  end

  def reply_location
    render "reply", formats: :xml
  end

  def reply_link
    render "reply", formats: :xml
  end

  def reply_event
    render "reply", formats: :xml
  end

  def reply_music
    render "reply", formats: :xml
  end

  def reply_news
    render "reply", formats: :xml
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

