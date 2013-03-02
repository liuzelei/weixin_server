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
      content += response["basic"]["explains"].join("; ") if response["basic"]
      content += "\n"
      content += (response["web"].to_a.collect{|w| w["key"]+": ["+w['value'].join(' ')+"]"}).join("\n")
    end

    def answer_question(term)
      uri = URI "http://localhost:9200/knowledges/_search"
      #opts = {headers: {"Accept-Encoding"=>'gzip'}}
      uri.query = {size: 1, pretty: "true", q: term}.to_query
      response = HTTParty.get(uri.to_s).parsed_response
      (response["hits"].is_a?(Hash) and response["hits"]["hits"].is_a?(Array)) ? response["hits"]["hits"].first["_source"]["content"] : "没找到答案哦，试试其它问题？"
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

