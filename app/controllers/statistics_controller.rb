# encoding: utf-8
class StatisticsController < ApplicationController
  def messages
  end

  def keywords
    @wx_texts = WxText.select("content, count(content) as count").group(:content).order("count desc")
  end

  def weixin_users
    @weixin_users = WeixinUser.all
  end

  # GET /statistics
  # GET /statistics.json
  def index
    #follow_stats = 

    req_stats = RequestMessage.group("date(created_at)").select("count(id) as count,date(created_at) as created_date").order("created_date")
    req_dates = req_stats.map {|it| it.created_date}
    req_data = req_stats.map {|it| it.count.to_i} #(&:count)
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
