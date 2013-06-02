# encoding: utf-8

module Weixin
  module Plugins
    class WeixinWeb

      class << self
        def logger
          @logger ||= Logger.new File.join(Rails.root,"log","weixin_web.log"), "weekly"
        end

        def steal_weixin_user_info
          if @current_weixin_user
            begin
              logger.info "start selenium stealing..."
              @selenium = Selenium::Client::Driver.new \
                :host => "58.221.80.116",
                :port => 14444,
                #:host => "localhost",
                #:port => 4444,
                :browser => "firefox",
                :url => "https://mp.weixin.qq.com/",
                :timeout_in_second => 60
              @selenium.start_new_browser_session

              @selenium.open "/cgi-bin/loginpage?t=wxm2-login&lang=zh_CN"
              @selenium.type "id=account", "as181920@hotmail.com"
              @selenium.type "id=password", "wx.password"
              @selenium.click "id=login_button"
              @selenium.wait_for_page_to_load "30000"
              @selenium.click "link=实时消息"
              @selenium.wait_for_page_to_load "30000"
              #@selenium.open "/cgi-bin/getmessage?t=wxm-message&token=2108901173&lang=zh_CN&count=50"
              #@selenium.wait_for_page_to_load "30000"
              @weixin_user_name = @selenium.get_text "xpath=/html/body/div[3]/div/div/div[2]/ul/li/div/a"
              @weixin_user_avatar = "https://mp.weixin.qq.com" + @selenium.get_attribute("xpath=/html/body/div[3]/div/div/div[2]/ul/li/a/img/@src")
              #puts @selenium.get_text "xpath=/html/body/div[8]/div[2]/div[2]/div/span"
              #@weixin_user_last_msg = @selenium.get_text "xpath=/html/body/div[3]/div/div/div[2]/ul/li/div/div[3]"

              logger.info "save weixin user info..."
              logger.info @weixin_user_name
              logger.info @weixni_user_avatar
              @current_weixin_user.update_attributes name: @weixin_user_name, avatar: @weixin_user_avatar

              @selenium.close_current_browser_session
              logger.info "selenium stealing finished."
            rescue => e
              logger.error "error occured when selenium stealing."
              logger.error e
              @selenium.close_current_browser_session
            end
          else
            logger.info "nil weixin user"
          end
        end
      end
    end

    def test_lib
      #binding.pry
    end

    def translate_word(word)
      uri = URI "http://fanyi.youdao.com/openapi.do"
      #opts = {headers: {"Accept-Encoding"=>'gzip'}}
      uri.query = {keyfrom: "as181920", key: "1988647871", type: "data", doctype: "json", version: "1.1", q: word}.to_query
      response = HTTParty.get(uri.to_s).parsed_response

      content  = response["translation"].is_a?(Array) ? response["translation"].join(",") : ""
      content += "\n"
      content += response["basic"]["explains"].join("; ") if response["basic"]
      content += "\n"
      content += (response["web"].to_a.collect{|w| w["key"]+": ["+w['value'].join(' ')+"]"}).join("\n")
    end

    def answer_question(term)
      uri = URI "http://localhost:9200/knowledges/_search"
      #opts = {headers: {"Accept-Encoding"=>'gzip'}}
      uri.query = {size: 1, pretty: "true", q: term}.to_query
      response = HTTParty.get(uri.to_s).parsed_response
      (response["hits"].is_a?(Hash) and response["hits"]["hits"].present?) ? response["hits"]["hits"].first["_source"]["content"] : "没找到答案哦，试试其它问题？"
    rescue => e
      "遇到异常了，试试其它问题？"
    end
  end
end

class String
  def split_all(content='')
    content = self if content.empty?
    content.split(/、|，|,|;|；|\ +|\||\r\n/) if content.class.eql? self.class
    #content.split(/[\p{Punctuation}\p{Symbol}]/) if content.class.eql? self.class
  end

  def to_search_string
    self.gsub(/[\p{Punctuation}\p{Symbol}]/, " ")                                                                                                          
  end
end

