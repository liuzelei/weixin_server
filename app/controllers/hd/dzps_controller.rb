class Hd::DzpsController < ApplicationController
  # GET /hd/dzps
  # GET /hd/dzps.json
  def index
    @hd_dzps = current_user.dzps

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hd_dzps }
    end
  end

  # GET /hd/dzps/1
  # GET /hd/dzps/1.json
  def show
    @hd_dzp = current_user.dzps.find(params[:id])

    @cnt_histories = @hd_dzp.dzp_histories.count
    @cnt_got_prize = @hd_dzp.dzp_histories.where("prize is not null").count

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hd_dzp }
    end
  end

  # GET /hd/dzps/new
  # GET /hd/dzps/new.json
  def new
    @hd_dzp = current_user.dzps.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hd_dzp }
    end
  end

  # GET /hd/dzps/1/edit
  def edit
    @hd_dzp = current_user.dzps.find(params[:id])
  end

  # POST /hd/dzps
  # POST /hd/dzps.json
  def create
    @hd_dzp = current_user.dzps.new(params[:hd_dzp])

    respond_to do |format|
      if current_user.save
        format.html { redirect_to @hd_dzp, notice: 'Dzp was successfully created.' }
        format.json { render json: @hd_dzp, status: :created, location: @hd_dzp }
      else
        format.html { render action: "new" }
        format.json { render json: @hd_dzp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hd/dzps/1
  # PUT /hd/dzps/1.json
  def update
    @hd_dzp = current_user.dzps.find(params[:id])

    respond_to do |format|
      if @hd_dzp.update_attributes(params[:hd_dzp])
        format.html { redirect_to @hd_dzp, notice: 'Dzp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hd_dzp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hd/dzps/1
  # DELETE /hd/dzps/1.json
  def destroy
    @hd_dzp = current_user.dzps.find(params[:id])
    @hd_dzp.destroy

    respond_to do |format|
      format.html { redirect_to hd_dzps_url }
      format.json { head :no_content }
    end
  end
end
