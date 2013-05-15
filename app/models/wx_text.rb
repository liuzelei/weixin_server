class WxText < ActiveRecord::Base
  attr_accessible :content, :weixin_user_id
  belongs_to :weixin_user

end

