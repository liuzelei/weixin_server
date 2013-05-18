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
    last_response_message = ResponseMessage.where(weixin_user_id: @current_weixin_user.id).order("created_at desc").first.try :content
    @qa_step = QaStep.where(question: last_response_message).first
    keyword_reply = KeywordReply.where(keyword: @request_content).first unless @qa_step
    if @qa_step.present?
      @response_text_content = weixin_user_info_recording
      @response_msg_type = "text"
      render "text", formats: :xml
    elsif keyword_reply.present?
      if keyword_reply.coupon
        @news = News.find keyword_reply.news_id
        @coupon = Coupon.where(weixin_user_id: @current_weixin_user.id).first
        @sn_code = @coupon.try(:sn_code) || generate_new_sn_code
        save_coupon_info
        @response_msg_type = "news"
        render "news_coupon", formats: :xml
      elsif keyword_reply.news_id.present?
        @news = News.find keyword_reply.news_id
        @response_msg_type = "news"
        render "news", formats: :xml
      else
        @response_text_content = keyword_reply.reply_content
        @response_msg_type = "text"
        render "text", formats: :xml
      end
    else
      @response_text_content = @request_content
      @response_msg_type = "text"
      render "text", formats: :xml
    end
  end

  def input_image
    render "reply", formats: :xml
    #render "news", formats: :xml
  end

  def input_location
    last_response_message = ResponseMessage.where(weixin_user_id: @current_weixin_user.id).order("created_at desc").first.try :content
    @qa_step = QaStep.where(question: last_response_message).first
    if @qa_step.present?
      @response_text_content = weixin_user_info_recording
    else
      @response_text_content = @request_content
    end

    @response_msg_type = "text"
    render "text", formats: :xml
  end

  def input_link
    render "reply", formats: :xml
  end

  def input_event
    req_event = params[:xml][:Event].to_s
    @response_text_content = \
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
    save_request_common_data
    save_request_detail_data
  end
  def save_request_common_data
    msg_type = params[:xml][:MsgType]
    @current_request_message = @current_weixin_user.request_messages.create msg_type: msg_type, xml: params[:xml]
  end
  def save_request_detail_data
    msg_type = params[:xml][:MsgType]
    case msg_type
    when "text"
      @request_content = params[:xml][:Content].to_s
      @current_weixin_user.wx_texts.create \
        request_message_id: @current_request_message.id,
        content: @request_content
    when "image"
      pic_url = params[:xml][:PicUrl]
      @current_weixin_user.wx_images.create \
        request_message_id: @current_request_message.id,
        pic_url: pic_url
    when "location"
      @current_weixin_user.wx_locations.create \
        request_message_id: @current_request_message.id,
        location_x: params[:xml][:Location_X],
        location_y: params[:xml][:Location_Y],
        scale: params[:xml][:Scale]
    when "link"
      @current_weixin_user.wx_links.create \
        request_message_id: @current_request_message.id,
        title: params[:xml][:Title],
        description: params[:xml][:Description],
        url: params[:xml][:Url]
    when "event"
      @current_weixin_user.wx_events.create \
        request_message_id: @current_request_message.id,
        event: params[:xml][:Event],
        event_key: params[:xml][:EventKey]
    else
      logger.info "did not save any detail data for request message"
    end
  end

  # 保存响应数据到数据库
  def save_response
    res_msg = ResponseMessage.new \
        weixin_user_id: @current_weixin_user.id,
        request_message_id: @current_request_message.id,
        msg_type: @response_msg_type
    case @response_msg_type
    when "text"
        res_msg.content = @response_text_content
    when "news"
        res_msg.news_id = @news.id
    when "music"
      logger.info "response message type is music"
    else
      logger.info "did not know response message type"
    end

    res_msg.save
  end

  # 保存派发的优惠码信息
  def save_coupon_info
    if @coupon
      @coupon.update_attribute(:updated_at, DateTime.now)
    else
      Coupon.create \
        weixin_user_id: @current_weixin_user.id,
        sn_code: @sn_code,
        status: "已派发"
    end
  end

  def generate_new_sn_code
    sn_code = Random.rand(1000000...10000000).to_s
    loop do
      break unless Coupon.where(sn_code: sn_code).present?
      logger.info sn_code = Random.rand(1000000...10000000).to_s
    end
    sn_code
  end

  def weixin_user_info_recording
    keyword = @qa_step.keyword
    case keyword
    when "zh"
      @current_weixin_user.update_attributes weixin_id: @request_content
    when "xb"
      @current_weixin_user.update_attributes sex: @request_content
    when "nl"
      @current_weixin_user.update_attributes age: @request_content
    when "dz"
      #address = params[:xml].keep_if {|k,v| ["Location_X","Location_Y","Scale"].include? k}
      @current_weixin_user.update_attributes \
        location_x: params[:xml][:Location_X],
        location_y: params[:xml][:Location_Y],
        scale: params[:xml][:Scale]
    else
      logger.info params[:xml]
    end
    next_step = QaStep.where("priority > ?", @qa_step.priority).order("priority").first.try(:question) || "信息录入完成\n输入cd获取菜单"
  end
end

