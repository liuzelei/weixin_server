class Hd::GgksController < ApplicationController
  # GET /hd/ggks
  # GET /hd/ggks.json
  def index
    @hd_ggks = Hd::Ggk.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hd_ggks }
    end
  end

  # GET /hd/ggks/1
  # GET /hd/ggks/1.json
  def show
    @hd_ggk = Hd::Ggk.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hd_ggk }
    end
  end

  # GET /hd/ggks/new
  # GET /hd/ggks/new.json
  def new
    @hd_ggk = Hd::Ggk.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hd_ggk }
    end
  end

  # GET /hd/ggks/1/edit
  def edit
    @hd_ggk = Hd::Ggk.find(params[:id])
  end

  # POST /hd/ggks
  # POST /hd/ggks.json
  def create
    @hd_ggk = Hd::Ggk.new(params[:hd_ggk])

    respond_to do |format|
      if @hd_ggk.save
        format.html { redirect_to @hd_ggk, notice: 'Ggk was successfully created.' }
        format.json { render json: @hd_ggk, status: :created, location: @hd_ggk }
      else
        format.html { render action: "new" }
        format.json { render json: @hd_ggk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hd/ggks/1
  # PUT /hd/ggks/1.json
  def update
    @hd_ggk = Hd::Ggk.find(params[:id])

    respond_to do |format|
      if @hd_ggk.update_attributes(params[:hd_ggk])
        format.html { redirect_to @hd_ggk, notice: 'Ggk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hd_ggk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hd/ggks/1
  # DELETE /hd/ggks/1.json
  def destroy
    @hd_ggk = Hd::Ggk.find(params[:id])
    @hd_ggk.destroy

    respond_to do |format|
      format.html { redirect_to hd_ggks_url }
      format.json { head :no_content }
    end
  end
end
