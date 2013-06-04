class Audio < ActiveRecord::Base
  attr_accessible :title, :uuid

  def audio_url_origin
    "http://#{QINIU_BUCKET_AUDIO}.qiniudn.com/#{uuid}" if uuid
  end
end
