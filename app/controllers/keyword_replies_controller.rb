# encoding: utf-8
class KeywordRepliesController < ApplicationController

  def index
    if params[:term].present?
      @keyword_replies = current_user.keyword_replies.includes(:replies).where("keyword_replies.keyword like ?", "%#{params[:term]}%").order("keyword_replies.updated_at desc")
    else
      @keyword_replies = current_user.keyword_replies.includes(:replies).order("keyword_replies.updated_at desc")
    end
  end

  def show
    @keyword_reply = current_user.keyword_replies.find params[:id]
  end

  def new
    @keyword_reply = current_user.keyword_replies.new
    1.times { @keyword_reply.replies.build() }
  end

  def create
    @keyword_reply = current_user.keyword_replies.new(params[:keyword_reply])

    #if @keyword_reply.save
    if current_user.save
      #redirect_to @keyword_reply, notice: 'successfully created.'
      redirect_to keyword_replies_path, notice: 'successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @keyword_reply = current_user.keyword_replies.find params[:id]
  end

  def update
    @keyword_reply = current_user.keyword_replies.find params[:id]

      if @keyword_reply.update_attributes(params[:keyword_reply])
        redirect_to @keyword_reply
      else
        render action: "edit"
      end
  end

  def destroy
    @keyword_reply = current_user.keyword_replies.find params[:id]
    @keyword_reply.destroy

    redirect_to keyword_replies_path
  end
end
