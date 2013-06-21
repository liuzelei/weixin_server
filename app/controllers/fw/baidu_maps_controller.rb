class Fw::BaiduMapsController < ApplicationController
  # GET /fw/baidu_maps
  # GET /fw/baidu_maps.json
  def index
    @fw_baidu_maps = current_user.baidu_maps

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fw_baidu_maps }
    end
  end

  def serve
    @fw_baidu_map = current_user.baidu_maps.find(params[:id])

    render layout: "baidu_map"
  end

  # GET /fw/baidu_maps/1
  # GET /fw/baidu_maps/1.json
  def show
    @fw_baidu_map = current_user.baidu_maps.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fw_baidu_map }
    end
  end

  # GET /fw/baidu_maps/new
  # GET /fw/baidu_maps/new.json
  def new
    @fw_baidu_map = current_user.baidu_maps.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fw_baidu_map }
    end
  end

  # GET /fw/baidu_maps/1/edit
  def edit
    @fw_baidu_map = current_user.baidu_maps.find(params[:id])
  end

  # POST /fw/baidu_maps
  # POST /fw/baidu_maps.json
  def create
    @fw_baidu_map = current_user.baidu_maps.new(params[:fw_baidu_map])

    respond_to do |format|
      if current_user.save
        format.html { redirect_to @fw_baidu_map, notice: 'Baidu map was successfully created.' }
        format.json { render json: @fw_baidu_map, status: :created, location: @fw_baidu_map }
      else
        format.html { render action: "new" }
        format.json { render json: @fw_baidu_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fw/baidu_maps/1
  # PUT /fw/baidu_maps/1.json
  def update
    @fw_baidu_map = current_user.baidu_maps.find(params[:id])

    respond_to do |format|
      if @fw_baidu_map.update_attributes(params[:fw_baidu_map])
        format.html { redirect_to @fw_baidu_map, notice: 'Baidu map was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fw_baidu_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fw/baidu_maps/1
  # DELETE /fw/baidu_maps/1.json
  def destroy
    @fw_baidu_map = current_user.baidu_maps.find(params[:id])
    @fw_baidu_map.destroy

    respond_to do |format|
      format.html { redirect_to fw_baidu_maps_url }
      format.json { head :no_content }
    end
  end
end
