# encoding: utf-8
class MessageController < ApplicationController
  require 'rexml/document'
  require "yaml"

  def auth
    if signature_valid?(signature= params[:signature], timestamp = params[:timestamp], nonce= params[:nonce] )
      logger.info("signature is ok and return #{params[:echostr]}")
      render text: params[:echostr]
    end
  end

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
    res 
  end

  private
  def signature_valid?(signature,timestamp,nonce)
    token = YAML.load(File.read(File.join(Rails.root,"config/weixin.yml")))["token"]

    if token.present? and signature.present? and timestamp.present? and nonce.present?
      guess_signature = generate_signature(token,timestamp,nonce)
      guess_signature.eql? signature
    end
  end

  def generate_signature(token,timestamp,nonce)
    signature = [token.to_s,timestamp.to_s,nonce.to_s].sort.join("")
    Digest::SHA1.hexdigest(signature)
  end

end

