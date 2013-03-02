# encoding: utf-8

module Weixin
  module Plugins
    def translate_word(word)
      uri = URI "http://fanyi.youdao.com/openapi.do"
      #opts = {headers: {"Accept-Encoding"=>'gzip'}}
      uri.query = {keyfrom: "as181920", key: "1988647871", type: "data", doctype: "json", version: "1.1", q: word}.to_query
      response = HTTParty.get(uri.to_s).parsed_response

      content  = response["translation"].join(",")
      content += "\n"
      content += response["basic"]["explains"].join("; ")
      content += "\n"
      content += (response["web"].collect{|w| w["key"]+": ["+w['value'].join(' ')+"]"}).join("\n")

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

