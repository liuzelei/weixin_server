class StatsController < ApplicationController
  def keywords
    @wx_texts = WxText.select("content, count(content) as count").group(:content)
  end

  def weixin_users
    @weixin_users = WeixinUser.all
  end
end
