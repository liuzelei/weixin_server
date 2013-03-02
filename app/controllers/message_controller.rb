# encoding: utf-8
class MessageController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality

  def auth
    render :text => params[:echostr]
  end

  def talk
    if params[:xml][:MsgType] == "text"
      render "message", :formats => :xml
    end
  end

=begin
  def talk
    request.body.rewind
    body_data =  Hash.from_xml request.body.read
    data = body_data["xml"]
    logger.info "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    logger.info data
    res = <<END_TEXT
<xml>
<ToUserName><![CDATA[oLUkFj8Db856hPfy-V9jYfR1Hsro]]></ToUserName>
<FromUserName><![CDATA[gh_062972c0457c]]></FromUserName>
<CreateTime>#{Time.now.to_i}</CreateTime>
<MsgType><![CDATA[text]]></MsgType>
<Content><![CDATA[abc]]></Content>
<FuncFlag><![CDATA[0]]></FuncFlag>
</xml> 
END_TEXT
    logger.info res 
    logger.info "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    render text: res 
  end
=end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    token = YAML.load(File.read(File.join(Rails.root,"config/weixin.yml")))["token"]
    array = [token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end

