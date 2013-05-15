# encoding: utf-8
class MessageController < ApplicationController
  include Weixin::Plugins

  skip_before_filter :verify_authenticity_token
  prepend_before_filter :current_weixin_user
  before_filter :check_weixin_legality, :save_request

  after_filter :save_response

  def auth
    render :text => params[:echostr]
  end

  def talk
    render "reply", formats: :xml
  end

  def input_text
    #per_page = params[:per_page].present? ? params[:per_page].to_i : 19
    last_response_message = ResponseMessage.where(user_id: @current_weixin_user.id).order("created_at desc").first.try :content
    #TODO
    #if response_message match qa_steps
    #handle_info_steps #record the user info into db
    #elsif response_message match keyword_replies
    #handle_keyword_replies
    #else
    #handle_smart_talk
    #end
    qa_step = QaStep.where(question: last_response_message).first
    keyword_reply = KeywordReply.where(keyword: @request_content).first unless qa_step
    if qa_step
      @content = "qa_step handling."
      logger.info "qa_step handling."
    elsif keyword_reply
      @content = "keyword_reply handling.."
      logger.info "keyword_reply handling.."
    else
      @content = "smart_talk handling..."
      logger.info "smart_talk handling..."
    end

=begin
    @content = \
      case last_response_message
      when "请输入您的微信号"
        @current_weixin_user.update_attributes weixin_id: @request_content
        "请选择您的性别"
      when "请选择您的性别"
        sex = \
          case @request_content
          when 0,"0"
            true
          when 1,"1"
            false
          else
            nil
          end
        @current_weixin_user.update_attributes sex: sex
        "请选择您的年龄"
      when "请选择您的年龄"
        @current_weixin_user.update_attributes age: @request_content
        "请输入您的地址"
      when "请输入您的地址"
        @current_weixin_user.update_attributes address: @request_content
        "继续吧"
      else
        case @request_content
        when "ZL","zl"
          "请输入您的微信号"
        when "Hello2BizUser"
          "欢迎关注哦，输[文字]翻译，输[?文字]提问,输[ZL]填写资料:)"
        when /^\?|^？|？$|\?$/
          answer_question @request_content.to_search_string
        else
          translate_word @request_content
        end
      end
=end


    render "text", formats: :xml
  end

  def input_image
    render "reply", formats: :xml
  end

  def input_location
    render "reply", formats: :xml
  end

  def input_link
    render "reply", formats: :xml
  end

  def input_event
    req_event = params[:xml][:Event].to_s
    @content = \
      case @request_content
      when "subscribe"
        "欢迎关注哦，输[文字]翻译，输[?文字]提问:)"
      when /unsubscribe/
        "怎么退订了呢，好伤心哦:("
      else
        "Unknown"
      end

    render "event", formats: :xml
  end

  def input_music
    render "reply", formats: :xml
  end

  def input_news
    render "reply", formats: :xml
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [WEIXIN_TOKEN, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end

  # 保存请求客户OpenID
  def current_weixin_user
    req_user_id = params[:xml][:FromUserName]
    @current_weixin_user ||= (WeixinUser.find_by_open_id(req_user_id) || WeixinUser.create(open_id: req_user_id))
  end

  # 保存请求数据到数据库
  def save_request
    RequestMessage.create \
      xml: params[:xml]
    @request_content = params[:xml][:Content].to_s
    @current_weixin_user.wx_texts.create \
      content: @request_content
  end

  # 保存响应数据到数据库
  def save_response
    ResponseMessage.create \
      content: @content,
      user_id: @current_weixin_user.id
  end
end

