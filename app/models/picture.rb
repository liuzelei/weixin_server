class Picture < ActiveRecord::Base
  attr_accessible :title, :pic_uuid

  def pic_url_origin
    "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}"
  end
  def pic_url_large
    "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}-large"
  end
  def pic_url_small
    "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}-small"
  end
end
