class ReplyTextsController < ApplicationController
  # GET /reply_texts
  # GET /reply_texts.json
  def index
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 15
    @reply_texts = current_user.reply_texts.order("updated_at desc").page([params[:page].to_i,1].max).per(@per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reply_texts }
    end
  end

  # GET /reply_texts/1
  # GET /reply_texts/1.json
  def show
    @reply_text = current_user.reply_texts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reply_text }
    end
  end

  # GET /reply_texts/new
  # GET /reply_texts/new.json
  def new
    @reply_text = current_user.reply_texts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reply_text }
    end
  end

  # GET /reply_texts/1/edit
  def edit
    @reply_text = current_user.reply_texts.find(params[:id])
  end

  # POST /reply_texts
  # POST /reply_texts.json
  def create
    @reply_text = current_user.reply_texts.new(params[:reply_text])

    respond_to do |format|
      if current_user.save
        format.html { redirect_to @reply_text, notice: 'Reply text was successfully created.' }
        format.json { render json: @reply_text, status: :created, location: @reply_text }
      else
        format.html { render action: "new" }
        format.json { render json: @reply_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reply_texts/1
  # PUT /reply_texts/1.json
  def update
    @reply_text = current_user.reply_texts.find(params[:id])

    respond_to do |format|
      if @reply_text.update_attributes(params[:reply_text])
        format.html { redirect_to @reply_text, notice: 'Reply text was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reply_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reply_texts/1
  # DELETE /reply_texts/1.json
  def destroy
    @reply_text = current_user.reply_texts.find(params[:id])
    @reply_text.destroy

    respond_to do |format|
      format.html { redirect_to reply_texts_url }
      format.json { head :no_content }
    end
  end
end
