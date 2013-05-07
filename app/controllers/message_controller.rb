# encoding: utf-8
class MessageController < ApplicationController
  include Weixin::Plugins

  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality, :save_request, :save_from_user

  def auth
    render :text => params[:echostr]
  end

  def talk
    render "reply", formats: :xml
  end

  def reply_text
    #per_page = params[:per_page].present? ? params[:per_page].to_i : 19
    req_content = params[:xml][:Content].to_s
    @user.wx_texts.create \
      content: req_content
    @content = \
      case req_content
      when "Hello2BizUser"
        "欢迎关注哦，输[文字]翻译，输[?文字]提问:)"
      when /^\?|^？|？$|\?$/
        answer_question req_content.to_search_string
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
    req_event = params[:xml][:Event].to_s
    @content = \
      case req_content
      when "subscribe"
        "欢迎关注哦，输[文字]翻译，输[?文字]提问:)"
      when /unsubscribe/
        "怎么退订了呢，好伤心哦:("
      else
        "Unknown"
      end

    render "event", formats: :xml
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

  # 保存请求客户OpenID
  def save_from_user
    req_user_id = params[:xml][:FromUserName]
    @user = User.find_by_id(req_user_id) || User.create(open_id: req_user_id)
  end

  # 保存数据到数据库
  def save_request
    RequestMessage.create \
      xml: params[:xml]
  end
end

