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
      @content = weixin_user_info_recording
      render "text", formats: :xml
    elsif keyword_reply.present?
      if keyword_reply.coupon
        @news = News.find keyword_reply.news_id
        @coupon = Coupon.where(weixin_user_id: @current_weixin_user.id).first
        @sn_code = @coupon.try(:sn_code) || Random.rand(1000000...10000000).to_s
        save_coupon_info
        render "news_coupon", formats: :xml
      elsif keyword_reply.news_id.present?
        @news = News.find keyword_reply.news_id
        render "news", formats: :xml
      else
        @content = keyword_reply.reply_content
        render "text", formats: :xml
      end
    else
      @content = @request_content
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
      @content = weixin_user_info_recording
    else
      @content = @request_content
    end

    render "text", formats: :xml
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
    case params[:xml][:MsgType]
    when "text"
      @request_content = params[:xml][:Content].to_s
      @current_weixin_user.wx_texts.create \
        content: @request_content
    when "location"
      @current_weixin_user.wx_locations.create \
        location_x: params[:xml][:Location_X],
        location_y: params[:xml][:Location_Y],
        scale: params[:xml][:Scale]
    else
    end
  end

  # 保存响应数据到数据库
  def save_response
    #TODO 处理非文字回复内容的保存
    ResponseMessage.create \
      content: @content,
      weixin_user_id: @current_weixin_user.id
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

