class WeixinUsersController < ApplicationController
  # GET /weixin_users
  # GET /weixin_users.json
  def index
    if params[:term].present?
      @weixin_users = current_user.weixin_users.where("name like ?", "%#{params[:term]}%").order("updated_at desc")
    else
      @weixin_users = current_user.weixin_users.order("updated_at desc")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weixin_users }
    end
  end

  # GET /weixin_users/1
  # GET /weixin_users/1.json
  def show
    @weixin_user = current_user.weixin_users.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weixin_user }
    end
  end

  def messages
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 10
    @weixin_user = current_user.weixin_users.find(params[:id])
    @request_messages = @weixin_user.request_messages.includes(:response_message).includes(:weixin_user).includes(:wx_text).includes(:wx_location).includes(:wx_image).includes(:wx_event).includes(:wx_link).order("request_messages.created_at desc").page([params[:page].to_i,1].max).per(@per_page)
  end

  # GET /weixin_users/new
  # GET /weixin_users/new.json
  def new
    @weixin_user = current_user.weixin_users.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weixin_user }
    end
  end

  # GET /weixin_users/1/edit
  def edit
    @weixin_user = current_user.weixin_users.find(params[:id])
  end

  # POST /weixin_users
  # POST /weixin_users.json
  def create
    @weixin_user = current_user.weixin_users.new(params[:weixin_user])

    respond_to do |format|
      if @weixin_user.save
        format.html { redirect_to @weixin_user, notice: 'Weixin user was successfully created.' }
        format.json { render json: @weixin_user, status: :created, location: @weixin_user }
      else
        format.html { render action: "new" }
        format.json { render json: @weixin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weixin_users/1
  # PUT /weixin_users/1.json
  def update
    @weixin_user = current_user.weixin_users.find(params[:id])

    respond_to do |format|
      if @weixin_user.update_attributes(params[:weixin_user])
        format.html { redirect_to @weixin_user, notice: 'Weixin user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weixin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weixin_users/1
  # DELETE /weixin_users/1.json
  def destroy
    @weixin_user = current_user.weixin_users.find(params[:id])
    @weixin_user.destroy

    respond_to do |format|
      format.html { redirect_to weixin_users_url }
      format.json { head :no_content }
    end
  end
end
