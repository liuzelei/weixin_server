class SettingsController < ApplicationController
  load_and_authorize_resource

  # GET /settings
  # GET /settings.json
  def index
    #@settings = Setting.all
    #@welcome_message = Setting.find_by_name("welcome_message") || Setting.new(name: "welcome_message")
    #@default_message = Setting.find_by_name("default_message") || Setting.new(name: "default_message")
    @setting = current_user.setting || current_user.build_setting

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @settings }
    end
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
    @setting = Setting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @setting }
    end
  end

  # GET /settings/new
  # GET /settings/new.json
  def new
    #@setting = Setting.new
    @setting = current_user.setting || current_user.build_setting

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @setting }
    end
  end

  # GET /settings/1/edit
  def edit
    #@setting = Setting.find(params[:id])
    @setting = current_user.setting
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = current_user.build_setting params[:setting]

    respond_to do |format|
      if @setting.save
        format.html { redirect_to settings_path, notice: 'Setting was successfully created.' }
        #format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render json: @setting, status: :created, location: @setting }
      else
        format.html { render action: "index" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /settings/1
  # PUT /settings/1.json
  def update
    #@setting = Setting.find(params[:id])
    @setting = current_user.setting

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to settings_path, notice: 'Setting was successfully updated.' }
        #format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to settings_url }
      format.json { head :no_content }
    end
  end
end
