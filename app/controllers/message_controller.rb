# encoding: utf-8
class MessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality, :save_request

  def auth
    render :text => params[:echostr]
  end

  def talk
    render "reply", formats: :xml
  end

  def reply_text
    uri = URI "http://fanyi.youdao.com/openapi.do"
    #opts = {headers: {"Accept-Encoding"=>'gzip'}}
    #per_page = params[:per_page].present? ? params[:per_page].to_i : 19

    uri.query = {keyfrom: "as181920", key: "1988647871", type: "data", doctype: "json", version: "1.1", q: params[:xml][:Content].to_s}.to_query
    response = HTTParty.get(uri.to_s).parsed_response

    @content  = response["translation"].join(",")
    @content += response["basic"]["explains"].join("; ")
    @content += response["web"].collect{|w| w["key"]+": ["+w['value'].join(' ')+"] "}
    

    logger.info @content

    render "text", formats: :xml
  end

  def reply_image
    render "reply", formats: :xml
  end

  def reply_location
    render "reply", formats: :xml
  end

  def reply_link
    render "reply", formats: :xml
  end

  def reply_event
    render "reply", formats: :xml
  end

  def reply_music
    render "reply", formats: :xml
  end

  def reply_news
    render "reply", formats: :xml
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    token = YAML.load(File.read(File.join(Rails.root,"config/weixin.yml")))["token"]
    array = [token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end

  # 保存数据到数据库
  def save_request
    RequestMessage.create \
      xml: params[:xml]
  end
end

