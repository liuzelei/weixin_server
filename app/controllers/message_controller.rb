# encoding: utf-8
class MessageController < ApplicationController
  include Weixin::Plugins
  include WeixinUsersHelper

  skip_before_filter :authenticate_user!

  skip_before_filter :verify_authenticity_token
  prepend_before_filter :check_weixin_legality, :detect_user
  before_filter :save_request
  after_filter :save_response

  def input_text
    #per_page = params[:per_page].present? ? params[:per_page].to_i : 19
    #last_response_message = current_user.response_messages.where(weixin_user_id: @current_weixin_user.id).order("created_at desc").first.try :content
    last_response_message = @current_weixin_user.response_messages.order("created_at desc").first.try(:reply).try(:outline_content)
    if @qa_step = current_user.qa_steps.where(question: last_response_message).first
      @response_text_content = weixin_user_info_recording
      render "text", formats: :xml
    elsif @keyword_reply = current_user.keyword_replies.where(keyword: @request_text_content.to_s.split(",").first.downcase).first
      @item = @keyword_reply.replies.order("random()").first.item
      render "message/#{@item.class.to_s.underscore}", formats: :xml, locals: {item: @item}
      #send "reply_with_#{item.class.to_s.underscore}".to_sym, @item
    elsif @activity = current_user.activities.where("keyword like ?", "#{@request_text_content.split.first.to_s.downcase}%").first
      if @request_text_content.length < 4
        @response_text_content = "请输入【djq空格微信昵称】，不要漏了帐号哦"
        render "text", formats: :xml
      else
        @current_weixin_user.update_attributes weixin_id: @request_text_content.gsub(@activity.keyword,"").gsub('+',"")
        @coupon = generate_coupon
        render "news_coupon", formats: :xml
      end
    else
      reply_with_default
    end
  rescue => e
    logger.error e.to_s
    reply_with_default
  end

  def input_image
    reply_with_default
  end

  def input_location
    last_response_message = @current_weixin_user.response_messages.order("created_at desc").first.try(:reply).try(:outline_content)
    @qa_step = current_user.qa_steps.where(question: last_response_message).first
    if @qa_step.present?
      @response_text_content = weixin_user_info_recording
    else
      @response_text_content = find_nearest_shop
    end

    render "text", formats: :xml
  end

  def input_link
    reply_with_default
  end

  def input_event
    req_event = params[:xml][:Event].to_s
    @response_text_content = \
      case req_event
      when "subscribe"
        #Setting.find_by_name("welcome_message").try :content
        current_user.setting.try :welcome_message
      when /unsubscribe/
        "用户已退订，无法回复消息。"
      else
        "Unknown Weixin Event"
      end

    reply_or_default
    #render "event", formats: :xml
  end

  def input_others
    reply_or_default
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    #array = [WEIXIN_TOKEN, params[:timestamp], params[:nonce]].sort
    return true
    array = [current_user.setting.try(:token), params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end

  def detect_user
    detect_current_user
    current_weixin_user
  end
  # 保存请求客户OpenID
  def current_weixin_user
    weixin_open_id = params[:xml][:FromUserName]
    @current_weixin_user ||= (current_user.weixin_users.find_by_open_id(weixin_open_id) || current_user.weixin_users.create(open_id: weixin_open_id))
    WeixinWeb.delay.steal_weixin_user_info(current_user.id, @current_weixin_user.id)
  end

  # 保存请求数据到数据库
  def save_request
    save_request_common_data
    save_request_detail_data
  end
  def save_request_common_data
    msg_type = params[:xml][:MsgType]
    @current_request_message = current_user.request_messages.create \
      weixin_user_id: @current_weixin_user.id,
      msg_type: msg_type,
      xml: params[:xml]
  end
  def save_request_detail_data
    msg_type = params[:xml][:MsgType]
    send "save_request_detail_data_of_#{msg_type.to_s.underscore}".to_sym
  rescue => e
    logger.error "Exception: #{e.class}: #{e.message}" if e
    logger.info "not save request detail data because unknown msg_type"
  end
  def save_request_detail_data_of_
    logger.info "not save request detail data because nil msg_type"
  end
  def save_request_detail_data_of_text
    @request_text_content = params[:xml][:Content].to_s
    @current_request_message.create_wx_text \
      weixin_user_id: @current_weixin_user.id,
      content: @request_text_content
  end
  def save_request_detail_data_of_image
    pic_url = params[:xml][:PicUrl]
    @current_request_message.create_wx_image \
      weixin_user_id: @current_weixin_user.id,
      pic_url: pic_url
  end
  def save_request_detail_data_of_location
    @current_request_message.create_wx_location \
      weixin_user_id: @current_weixin_user.id,
      latitude: params[:xml][:Location_X],
      longitude: params[:xml][:Location_Y],
      scale: params[:xml][:Scale]
  end
  def save_request_detail_data_of_link
    @current_request_message.create_wx_link \
      weixin_user_id: @current_weixin_user.id,
      title: params[:xml][:Title],
      description: params[:xml][:Description],
      url: params[:xml][:Url]
  end
  def save_request_detail_data_of_event
    @current_request_message.create_wx_event \
      weixin_user_id: @current_weixin_user.id,
      event: params[:xml][:Event],
      event_key: params[:xml][:EventKey]
  end

  # 保存响应数据到数据库
  def save_response
    current_response_message = @current_request_message.create_response_message weixin_user_id: @current_weixin_user.id
    current_response_message.create_reply item_id: @item.id, item_type: @item.class.to_s if @item.present?
  end

  def reply_or_default
    @response_text_content ||= current_user.setting.try :default_message
    render "text", formats: :xml
  end
  def reply_with_default
    #@response_text_content = Setting.find_by_name("default_message").try :content 
    @response_text_content = current_user.setting.try :default_message
    render "text", formats: :xml
  end

  # 保存派发的优惠码信息
  def generate_coupon
    @coupon = current_user.coupons.where(weixin_user_id: @current_weixin_user.id).first || current_user.coupons.create(weixin_user_id: @current_weixin_user.id, sn_code: generate_new_sn_code, status: "已派发")
  end

  def generate_new_sn_code
    @sn_code = Random.rand(1000000...10000000).to_s
    #loop do
    #  break unless current_user.coupons.where(sn_code: @sn_code).present?
    #  logger.info @sn_code = Random.rand(1000000...10000000).to_s
    #end
    @sn_code
  end

  def weixin_user_info_recording
    keyword = @qa_step.keyword
    case keyword
    when "zh"
      @current_weixin_user.update_attributes weixin_id: @request_text_content
    when "xb"
      @current_weixin_user.update_attributes sex: @request_text_content
    when "nl"
      @current_weixin_user.update_attributes age: @request_text_content
    when "dz"
      #address = params[:xml].keep_if {|k,v| ["Location_X","Location_Y","Scale"].include? k}
      @current_weixin_user.update_attributes \
        latitude: params[:xml][:Location_X],
        longitude: params[:xml][:Location_Y],
        scale: params[:xml][:Scale]
    else
      logger.info params[:xml]
    end
    next_step = current_user.qa_steps.where("priority > ?", @qa_step.priority).order("priority").first.try(:question) || "恭喜您已经成为我的忠实粉丝，会有更多惊喜等着你哦！发送【M】查看菜单"
  end

  def find_nearest_shop
    current_location = @current_request_message.wx_location
    current_geo_info = [current_location.latitude, current_location.longitude]
    shop = current_user.shops.near(current_geo_info,50,units: :km).first
    if shop
      "#{shop.name}\n#{shop.address}"
    else
      "未找到附近的门店，输入【M】查看菜单"
    end
  end
end

