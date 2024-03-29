class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @news = current_user.news.find params[:news_id]
    @item = @news.items.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @news = current_user.news.find params[:news_id]
    @item = @news.items.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @news = current_user.news.find params[:news_id]
    @item = @news.items.new(params[:item])

    if @item.save
      redirect_to @news, notice: 'Item was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @news = current_user.news.find params[:news_id]
    @item = @news.items.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @news, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @news = current_user.news.find params[:news_id]
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to @news }
      format.json { head :no_content }
    end
  end
end
