class Hd::GgkHistoriesController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]
  # GET /hd/ggk_histories
  # GET /hd/ggk_histories.json
  def index
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 100

    @hd_ggk = current_user.ggks.find params[:ggk_id]
    @hd_ggk_histories = @hd_ggk.ggk_histories

    if params[:prize]
      @histories = @hd_ggk.ggk_histories.where("prize is not null").order("hd_ggk_histories.updated_at desc").page([params[:page].to_i,1].max).per(@per_page)
    else
      @histories = @hd_ggk.ggk_histories.order("hd_ggk_histories.updated_at desc").page([params[:page].to_i,1].max).per(@per_page)
    end

		@cnt_all = @hd_ggk.ggk_histories.count
		@cnt_got_prize = @hd_ggk.ggk_histories.where("prize is not null").count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hd_ggk_histories }
    end
  end

  # GET /hd/ggk_histories/1
  # GET /hd/ggk_histories/1.json
  def show
    @hd_ggk = Hd::Ggk.find params[:ggk_id]
    @hd_ggk_history = @hd_ggk.ggk_histories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hd_ggk_history }
    end
  end

  # GET /hd/ggk_histories/new
  # GET /hd/ggk_histories/new.json
  def new
    @hd_ggk_history = Hd::GgkHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hd_ggk_history }
    end
  end

  # GET /hd/ggk_histories/1/edit
  def edit
    @hd_ggk_history = Hd::GgkHistory.find(params[:id])
  end

  # POST /hd/ggk_histories
  # POST /hd/ggk_histories.json
  def create
    @hd_ggk_history = Hd::GgkHistory.new(params[:hd_ggk_history])

    respond_to do |format|
      if @hd_ggk_history.save
        format.html { redirect_to @hd_ggk_history, notice: 'Ggk history was successfully created.' }
        format.json { render json: @hd_ggk_history, status: :created, location: @hd_ggk_history }
      else
        format.html { render action: "new" }
        format.json { render json: @hd_ggk_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hd/ggk_histories/1
  # PUT /hd/ggk_histories/1.json
  def update
    @hd_ggk_history = Hd::GgkHistory.find(params[:id])

    respond_to do |format|
      if @hd_ggk_history.update_attributes(params[:hd_ggk_history])
        format.html { redirect_to @hd_ggk_history, notice: 'Ggk history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hd_ggk_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hd/ggk_histories/1
  # DELETE /hd/ggk_histories/1.json
  def destroy
    @hd_ggk_history = Hd::GgkHistory.find(params[:id])
    @hd_ggk_history.destroy

    respond_to do |format|
      format.html { redirect_to hd_ggk_histories_url }
      format.json { head :no_content }
    end
  end
end
