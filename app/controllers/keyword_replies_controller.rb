# encoding: utf-8
class KeywordRepliesController < ApplicationController

  def index
    @keyword_replies = KeywordReply.order("updated_at desc")
  end

  def show
    @keyword_reply = KeywordReply.find params[:id]
  end

  def new
    @keyword_reply = KeywordReply.new
    1.times { @keyword_reply.replyings.build() }
  end

  def create
    @keyword_reply = KeywordReply.new(params[:keyword_reply])

    if @keyword_reply.save
      #redirect_to @keyword_reply, notice: 'successfully created.'
      redirect_to keyword_replies_path, notice: 'successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @keyword_reply = KeywordReply.find params[:id]
  end

  def update
    @keyword_reply = KeywordReply.find params[:id]

      if @keyword_reply.update_attributes(params[:keyword_reply])
        redirect_to @keyword_reply
      else
        render action: "edit"
      end
  end

  def destroy
    @keyword_reply = KeywordReply.find params[:id]
    @keyword_reply.destroy

    redirect_to keyword_replies_path
  end
end
