class AudiosController < ApplicationController
  # GET /audios
  # GET /audios.json
  def index
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 15
    @audios = Audio.order("updated_at desc").page([params[:page].to_i,1].max).per(@per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audios }
    end
  end

  # GET /audios/1
  # GET /audios/1.json
  def show
    @audio = Audio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audio }
    end
  end

  # GET /audios/new
  # GET /audios/new.json
  def new
    @audio = Audio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audio }
    end
  end

  # GET /audios/1/edit
  def edit
    @audio = Audio.find(params[:id])
  end

  # POST /audios
  # POST /audios.json
  def create
    @audio = Audio.new(params[:audio])

    respond_to do |format|
      if @audio.save
        format.html { redirect_to @audio, notice: 'Audio was successfully created.' }
        format.json { render json: @audio, status: :created, location: @audio }
      else
        format.html { render action: "new" }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /audios/1
  # PUT /audios/1.json
  def update
    @audio = Audio.find(params[:id])

    respond_to do |format|
      if @audio.update_attributes(params[:audio])
        format.html { redirect_to @audio, notice: 'Audio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audios/1
  # DELETE /audios/1.json
  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy

    respond_to do |format|
      format.html { redirect_to audios_url }
      format.json { head :no_content }
    end
  end
end
