class Hd::DzpHistoriesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]

  # GET /hd/dzp_histories
  # GET /hd/dzp_histories.json
  def index
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 100

    @hd_dzp = current_user.dzps.find params[:dzp_id]
    @hd_dzp_histories = @hd_dzp.dzp_histories

    if params[:prize]
      @histories = @hd_dzp.dzp_histories.where("prize is not null").order("hd_dzp_histories.updated_at desc").page([params[:page].to_i,1].max).per(@per_page)
    else
      @histories = @hd_dzp.dzp_histories.order("hd_dzp_histories.updated_at desc").page([params[:page].to_i,1].max).per(@per_page)
    end

		@cnt_all = @hd_dzp.dzp_histories.count
		@cnt_got_prize = @hd_dzp.dzp_histories.where("prize is not null").count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hd_dzp_histories }
    end
  end

  # GET /hd/dzp_histories/1
  # GET /hd/dzp_histories/1.json
  def show
    @hd_dzp = current_user.dzps.find params[:dzp_id]
    @hd_dzp_history = @hd_dzp.dzp_histories.find(params[:id])

    render layout: false
  end

  # GET /hd/dzp_histories/new
  # GET /hd/dzp_histories/new.json
  def new
    @hd_dzp_history = Hd::DzpHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hd_dzp_history }
    end
  end

  # GET /hd/dzp_histories/1/edit
  def edit
    @hd_dzp_history = Hd::DzpHistory.find(params[:id])
  end

  # POST /hd/dzp_histories
  # POST /hd/dzp_histories.json
  def create
    @hd_dzp_history = Hd::DzpHistory.new(params[:hd_dzp_history])

    respond_to do |format|
      if @hd_dzp_history.save
        format.html { redirect_to @hd_dzp_history, notice: 'Dzp history was successfully created.' }
        format.json { render json: @hd_dzp_history, status: :created, location: @hd_dzp_history }
      else
        format.html { render action: "new" }
        format.json { render json: @hd_dzp_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hd/dzp_histories/1
  # PUT /hd/dzp_histories/1.json
  def update
    @hd_dzp_history = Hd::DzpHistory.find(params[:id])

    respond_to do |format|
      if @hd_dzp_history.update_attributes(params[:hd_dzp_history])
        format.html { redirect_to @hd_dzp_history, notice: 'Dzp history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hd_dzp_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hd/dzp_histories/1
  # DELETE /hd/dzp_histories/1.json
  def destroy
    @hd_dzp_history = Hd::DzpHistory.find(params[:id])
    @hd_dzp_history.destroy

    respond_to do |format|
      format.html { redirect_to hd_dzp_histories_url }
      format.json { head :no_content }
    end
  end
end
