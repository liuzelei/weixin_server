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
    last_response_message = ResponseMessage.where(user_id: @user.id).order("id desc").first.try :content
    @user.wx_texts.create \
      content: req_content
    @content = \
      case last_response_message
      when "请输入您的微信号"
        @user.update_attributes weixin_id: req_content
        "请选择您的性别"
      when "请选择您的性别"
        sex = \
          case req_content
          when 0,"0"
            true
          when 1,"1"
            false
          else
            nil
          end
        @user.update_attributes sex: sex
        "请选择您的年龄"
      when "请选择您的年龄"
        @user.update_attributes age: req_content
        "继续吧"
      else
        case req_content
        when "ZL"
          "请输入您的微信号"
        when "Hello2BizUser"
          "欢迎关注哦，输[文字]翻译，输[?文字]提问:)"
        when /^\?|^？|？$|\?$/
          answer_question req_content.to_search_string
        else
          translate_word req_content
        end
      end
    ResponseMessage.create \
      content: @content,
      user_id: @user.id


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
    @user = User.find_by_open_id(req_user_id) || User.create(open_id: req_user_id)
  end

  # 保存数据到数据库
  def save_request
    RequestMessage.create \
      xml: params[:xml]
  end
end

