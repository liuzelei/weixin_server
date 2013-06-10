class NewsController < ApplicationController
  # GET /news
  # GET /news.json
  def index
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 15
    @news = current_user.news.includes(:items).order("news.updated_at desc").page([params[:page].to_i,1].max).per(@per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  def list
    @per_page = params[:per_page].present? ? params[:per_page].to_i : 100
    @news = current_user.news.order("updated_at desc").page([params[:page].to_i,1].max).per(@per_page)
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = current_user.news.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = current_user.news.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = current_user.news.find(params[:id])
  end

  # POST /news
  # POST /news.json
  def create
    @news = current_user.news.new(params[:news])

    respond_to do |format|
      if current_user.news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { render action: "new" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = current_user.news.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news = current_user.news.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url }
      format.json { head :no_content }
    end
  end
end
