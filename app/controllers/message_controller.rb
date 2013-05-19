# encoding: utf-8
class MessageController < ApplicationController
  include Weixin::Plugins

  skip_before_filter :verify_authenticity_token, except: [:auth]
  prepend_before_filter :current_weixin_user, except: [:auth]
  before_filter :check_weixin_legality, :save_request, except: [:auth]
  after_filter :save_response, except: [:auth]

  def auth
    render :text => params[:echostr]
  end

  def talk
    render "reply", formats: :xml
  end

  def input_text
    #per_page = params[:per_page].present? ? params[:per_page].to_i : 19
    last_response_message = ResponseMessage.where(weixin_user_id: @current_weixin_user.id).order("created_at desc").first.try :content
    if @qa_step = QaStep.where(question: last_response_message).first
      @response_text_content = weixin_user_info_recording
      @response_msg_type = "text"
      render "text", formats: :xml
    elsif keyword_reply = KeywordReply.where(keyword: @request_content).first
      if keyword_reply.news_id.present?
        @news = News.find keyword_reply.news_id
        @response_msg_type = "news"
        render "news", formats: :xml
      else
        @response_text_content = keyword_reply.reply_content
        @response_msg_type = "text"
        render "text", formats: :xml
      end
    elsif @activity = Activity.where("keyword like ?", "#{@request_content.split.first}%").first
      if @request_content.length < 4
        @response_text_content = "请输入【djq+空格+微信帐号】，不要漏了帐号哦"
        @response_msg_type = "text"
        render "text", formats: :xml
      else
        @current_weixin_user.update_attributes weixin_id: @request_content.gsub(@activity.keyword,"").gsub('+',"")
        @coupon = generate_coupon
        #@response_msg_type = "news"
        render "news_coupon", formats: :xml
      end
    else
      #@response_text_content = @request_content
      @response_text_content = "你好！我是越王珠宝的客服小珠，请输入【M】查看菜单"
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
      @response_text_content = find_nearest_shop
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
      case req_event
      when "subscribe"
        "感谢您关注越王珠宝官方微信账号！为了答谢您的厚爱，越王珠宝特推出价值200元微信代金卷，发送【djq空格微信号】即可领取。\n越王珠宝主办的“你就是我的世界——求婚梦想季”活动正在招募，现在报名，全面惊喜等着你！回复【qh】，可以了解详细信息， 您也可以直接发送留言报名参加活动。 登陆www.jovan.cc了解活动详情。发送【M】可以查看越王珠宝的更多活动。"
        #"欢迎关注哦，输[文字]翻译，输[?文字]提问:)"
      when /unsubscribe/
        "怎么退订了呢，好伤心哦:("
      else
        "Unknown"
      end

    render "event", formats: :xml
  end

  def input_others
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
        latitude: params[:xml][:Location_X],
        longitude: params[:xml][:Location_Y],
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
  def generate_coupon
    @coupon = Coupon.where(weixin_user_id: @current_weixin_user.id).first || Coupon.create(weixin_user_id: @current_weixin_user.id, sn_code: generate_new_sn_code, status: "已派发")
  end

  def generate_new_sn_code
    @sn_code = Random.rand(1000000...10000000).to_s
    loop do
      break unless Coupon.where(sn_code: @sn_code).present?
      logger.info @sn_code = Random.rand(1000000...10000000).to_s
    end
    @sn_code
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
        latitude: params[:xml][:Location_X],
        longitude: params[:xml][:Location_Y],
        scale: params[:xml][:Scale]
    else
      logger.info params[:xml]
    end
    next_step = QaStep.where("priority > ?", @qa_step.priority).order("priority").first.try(:question) || "恭喜您已经成为我的忠实粉丝，会有更多惊喜等着你哦！发送【M】查看菜单"
  end

  def find_nearest_shop
    current_location = @current_request_message.wx_location
    current_geo_info = [current_location.latitude, current_location.longitude]
    shop = Shop.near(current_geo_info,50,units: :km).first
    if shop
      "#{shop.name}\n#{shop.address}"
    else
      "未找到附近的门店，输入【M】查看菜单"
    end
  end
end

