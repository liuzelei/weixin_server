# encoding: utf-8
class StatisticsController < ApplicationController
  before_filter :check_settings, only: [:chart_messages]

  def msg_types
    @stats = current_user.request_messages.select("msg_type, count(msg_type) as cnt").group(:msg_type).order("cnt desc")
  end

  def follows
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 10
    # TODO search
    if params[:term].present?
      @request_follows = current_user.request_messages.joins(:weixin_user).where(msg_type: "event").where("weixin_users.name like ?", "%#{params[:term]}%").order("request_messages.created_at desc").page([params[:page].to_i,1].max).per(@per_page)
    else
      @request_follows = current_user.request_messages.where(msg_type: "event").order("created_at desc").page([params[:page].to_i,1].max).per(@per_page)
    end
  end

  def follows_export
    if params[:term].present?
      @request_follows = current_user.request_messages.joins(:weixin_user).where(msg_type: "event").where("weixin_users.name like ?", "%#{params[:term]}%").order("request_messages.created_at desc")
    else
      @request_follows = current_user.request_messages.where(msg_type: "event").order("created_at desc")
    end

    render layout: "export"
  end

  def detail

    @per_page = params[:per_page].present? ? params[:per_page].to_i : 20
    @q = current_user.request_messages.search(params[:q])
    @request_messages = @q.result.includes(:response_message).includes(:weixin_user).includes(:wx_text).includes(:wx_location).includes(:wx_image).includes(:wx_event).includes(:wx_link).order("request_messages.created_at desc").page([params[:page].to_i,1].max).per(@per_page)

=begin
    # TODO search
    if params[:weixin_user_id].present?
      @request_messages = current_user.request_messages.where("weixin_user_id = ?", params[:weixin_user_id]).order("created_at desc")
    elsif params[:term].present?
      #@request_messages = current_user.request_messages.joins(:wx_text).where("wx_texts.content like ?", "%#{params[:term]}%").select("request_messages.*, wx_texts.*").order("request_messages.created_at desc").page([params[:page].to_i,1].max).per(@per_page)
      @request_messages = current_user.request_messages.joins(:wx_text).where("wx_texts.content = ?", params[:term]).order("request_messages.created_at desc").page([params[:page].to_i,1].max).per(@per_page)
    else
      #@request_messages = current_user.request_messages.where("msg_type != ?", "event").order("created_at desc").page([params[:page].to_i,1].max).per(@per_page)
      @request_messages = current_user.request_messages.order("created_at desc").page([params[:page].to_i,1].max).per(@per_page)
    end
=end
  end

  def detail_export
    @q = current_user.request_messages.search(params[:q])
    @request_messages = @q.result.includes(:response_message).includes(:weixin_user).includes(:wx_text).includes(:wx_location).includes(:wx_image).includes(:wx_event).includes(:wx_link).order("request_messages.created_at desc")
    render layout: "export"
  end

  def dates
    @req_stats = current_user.request_messages.group("created_date").select("date(request_messages.created_at) as created_date, count(1) as cnt").order("created_date desc")
  end

  def weixin_users_dates
    @req_stats = current_user.request_messages.includes(:weixin_user).group("weixin_user_id, created_date").select("count(weixin_user_id) as cnt, weixin_user_id, date(request_messages.created_at) as created_date").order("created_date desc")
  end

  def weixin_users
    @req_stats = current_user.request_messages.includes(:weixin_user).group("weixin_user_id").select("count(weixin_user_id) as cnt, weixin_user_id").order("cnt desc")
  end

  def keywords
    @keywords = current_user.keyword_replies.all.map(&:keyword)
    #@req_stats = WxText.where(content: @keywords).group("content").select("content, count(id) as cnt").order("cnt desc")
    @req_stats = WxText.where("lower(content) in (?)", @keywords).group("lower_content").select("lower(content) as lower_content, count(id) as cnt").order("cnt desc")
  end

  def messages
    @wx_texts = WxText.select("content, count(content) as cnt").group(:content).order("cnt desc")
  end

  def chart_messages
    req_stats = current_user.request_messages.group("date(request_messages.created_at)").select("count(request_messages.id) as cnt, date(request_messages.created_at) as created_date").order("created_date")
    req_dates = req_stats.map {|it| it.created_date}
    req_data = req_stats.map {|it| it.cnt.to_i} #(&:cnt)
    @req_stat_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.legend(enabled: false)
      f.title({ :text=>"每日接收消息数"})
      f.options[:xAxis][:categories] = req_dates
      f.series(:type=> 'spline',:name=> '消息数', :data=> req_data)
    end
  end
  def chart_messages_add_up
    req_stats = current_user.request_messages.group("date(request_messages.created_at)").select("count(request_messages.id) as cnt, date(request_messages.created_at) as created_date").order("created_date")
    req_dates = req_stats.map {|it| it.created_date}
    sum = 0
    req_data = req_stats.inject([]){|res,it| res<<sum+=it.cnt.to_i}
    @req_stat_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.legend(enabled: false)
      f.title({ :text=>"累计接收消息数"})
      f.options[:xAxis][:categories] = req_dates
      f.series(:type=> 'spline',:name=> '消息数', :data=> req_data)
    end
  end

  def chart_follows
    follow_stats = WxEvent.where(event: "subscribe").group("date(created_at)").select("count(id) as cnt, date(created_at) as created_date").order("created_date")
    follow_dates = follow_stats.map {|it| it.created_date}
    follow_data = follow_stats.map {|it| it.cnt.to_i}
    @follow_stat_chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.legend(enabled: false)
      f.title(text: "每日新增订阅人数")
      f.options[:xAxis][:categories] = follow_dates
      f.series(type: "spline", name: "新增订阅数", data: follow_data)
    end
  end
  def chart_follows_add_up
    follow_stats = WxEvent.where(event: "subscribe").group("date(created_at)").select("count(id) as cnt, date(created_at) as created_date").order("created_date")
    follow_dates = follow_stats.map {|it| it.created_date}
    sum = 0
    follow_data = follow_stats.inject([]) {|res,it| res<<sum+=it.cnt.to_i}
    @follow_stat_chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.legend(enabled: false)
      f.title(text: "累计新增订阅人数")
      f.options[:xAxis][:categories] = follow_dates
      f.series(type: "spline", name: "订阅数", data: follow_data)
    end
  end
  # GET /statistics
  # GET /statistics.json
  def index
    follow_stats = WxEvent.where(event: "subscribe").group("date(created_at)").select("count(id) as cnt, date(created_at) as created_date").order("created_date")
    follow_dates = follow_stats.map {|it| it.created_date}
    follow_data = follow_stats.map {|it| it.cnt.to_i}
    @follow_stat_chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.legend(enabled: false)
      f.title(text: "每日新增订阅人数")
      f.options[:xAxis][:categories] = follow_dates
      f.series(type: "spline", name: "新增订阅数", data: follow_data)
    end

    req_stats = current_user.request_messages.group("date(created_at)").select("count(id) as cnt, date(created_at) as created_date").order("created_date")
    req_dates = req_stats.map {|it| it.created_date}
    req_data = req_stats.map {|it| it.cnt.to_i} #(&:cnt)
    @req_stat_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.legend(enabled: false)
      f.title({ :text=>"每日接收消息数"})
      f.options[:xAxis][:categories] = req_dates
      f.series(:type=> 'spline',:name=> '消息数', :data=> req_data)
    end

  end

  private
  def check_settings
    redirect_to settings_path unless current_user.setting.present?
  end
end
