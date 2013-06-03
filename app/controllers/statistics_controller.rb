# encoding: utf-8
class StatisticsController < ApplicationController

  def msg_types
    @stats = RequestMessage.select("msg_type, count(msg_type) as cnt").group(:msg_type).order("cnt desc")
  end

  def follows
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 10
    # TODO search
    if params[:term].present?
      @request_follows = RequestMessage.joins(:weixin_user).where(msg_type: "event").where("weixin_users.weixin_id like ?", "%#{params[:term]}%").order("request_messages.created_at desc").page([params[:page].to_i,1].max).per(@per_page)
    else
      @request_follows = RequestMessage.where(msg_type: "event").order("created_at desc").page([params[:page].to_i,1].max).per(@per_page)
    end
  end

  def follows_export
    if params[:term].present?
      @request_follows = RequestMessage.joins(:weixin_user).where(msg_type: "event").where("weixin_users.weixin_id like ?", "%#{params[:term]}%").order("request_messages.created_at desc")
    else
      @request_follows = RequestMessage.where(msg_type: "event").order("created_at desc")
    end

    render layout: "export"
  end

  def detail

    @per_page = params[:per_page].present? ? params[:per_page].to_i : 10
    @q = RequestMessage.search(params[:q])
    @request_messages = @q.result.includes(:response_message).includes(:weixin_user).includes(:wx_text).includes(:wx_location).includes(:wx_image).includes(:wx_event).includes(:wx_link).order("request_messages.created_at desc").page([params[:page].to_i,1].max).per(@per_page)

=begin
    # TODO search
    if params[:weixin_user_id].present?
      @request_messages = RequestMessage.where("weixin_user_id = ?", params[:weixin_user_id]).order("created_at desc")
    elsif params[:term].present?
      #@request_messages = RequestMessage.joins(:wx_text).where("wx_texts.content like ?", "%#{params[:term]}%").select("request_messages.*, wx_texts.*").order("request_messages.created_at desc").page([params[:page].to_i,1].max).per(@per_page)
      @request_messages = RequestMessage.joins(:wx_text).where("wx_texts.content = ?", params[:term]).order("request_messages.created_at desc").page([params[:page].to_i,1].max).per(@per_page)
    else
      #@request_messages = RequestMessage.where("msg_type != ?", "event").order("created_at desc").page([params[:page].to_i,1].max).per(@per_page)
      @request_messages = RequestMessage.order("created_at desc").page([params[:page].to_i,1].max).per(@per_page)
    end
=end
  end

  def detail_export
    @q = RequestMessage.search(params[:q])
    @request_messages = @q.result.includes(:response_message).includes(:weixin_user).includes(:wx_text).includes(:wx_location).includes(:wx_image).includes(:wx_event).includes(:wx_link).order("request_messages.created_at desc")
    render layout: "export"
  end

  def dates
    @req_stats = RequestMessage.group("date(created_at)").select("count(id) as cnt, date(created_at) as created_date").order("created_date desc")
  end

  def weixin_users_dates
    @req_stats = RequestMessage.includes(:weixin_user).group("weixin_user_id, date(created_at)").select("count(id) as cnt, weixin_user_id, date(created_at) as created_date").order("created_date desc")
  end

  def weixin_users
    @req_stats = RequestMessage.includes(:weixin_user).group("weixin_user_id").select("count(weixin_user_id) as cnt, weixin_user_id").order("cnt desc")
  end

  def messages
    @wx_texts = WxText.select("content, count(content) as cnt").group(:content).order("cnt desc")
  end

  def chart_messages
    req_stats = RequestMessage.group("date(created_at)").select("count(id) as cnt, date(created_at) as created_date").order("created_date")
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
    req_stats = RequestMessage.group("date(created_at)").select("count(id) as cnt, date(created_at) as created_date").order("created_date")
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

    req_stats = RequestMessage.group("date(created_at)").select("count(id) as cnt, date(created_at) as created_date").order("created_date")
    req_dates = req_stats.map {|it| it.created_date}
    req_data = req_stats.map {|it| it.cnt.to_i} #(&:cnt)
    @req_stat_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.legend(enabled: false)
      f.title({ :text=>"每日接收消息数"})
      f.options[:xAxis][:categories] = req_dates
      f.series(:type=> 'spline',:name=> '消息数', :data=> req_data)
    end

  end

=begin
  # GET /statistics/1
  # GET /statistics/1.json
  def show
    @statistic = Statistic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statistic }
    end
  end

  # GET /statistics/new
  # GET /statistics/new.json
  def new
    @statistic = Statistic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statistic }
    end
  end

  # GET /statistics/1/edit
  def edit
    @statistic = Statistic.find(params[:id])
  end

  # POST /statistics
  # POST /statistics.json
  def create
    @statistic = Statistic.new(params[:statistic])

    respond_to do |format|
      if @statistic.save
        format.html { redirect_to @statistic, notice: 'Statistic was successfully created.' }
        format.json { render json: @statistic, status: :created, location: @statistic }
      else
        format.html { render action: "new" }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statistics/1
  # PUT /statistics/1.json
  def update
    @statistic = Statistic.find(params[:id])

    respond_to do |format|
      if @statistic.update_attributes(params[:statistic])
        format.html { redirect_to @statistic, notice: 'Statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistics/1
  # DELETE /statistics/1.json
  def destroy
    @statistic = Statistic.find(params[:id])
    @statistic.destroy

    respond_to do |format|
      format.html { redirect_to statistics_url }
      format.json { head :no_content }
    end
  end
=end
end
