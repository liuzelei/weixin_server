class Audio < ActiveRecord::Base
  attr_accessible :title, :uuid

  validates_presence_of :uuid

  def audio_url_origin
    "http://#{QINIU_BUCKET_AUDIO}.qiniudn.com/#{uuid}"
  end

  def audio_url_m3u8
    "http://#{QINIU_BUCKET_AUDIO}.qiniudn.com/#{uuid}.m3u8_audio"
  end

  def audio_url_wav
    "http://#{QINIU_BUCKET_AUDIO}.qiniudn.com/#{uuid}.wav_audio"
  end
end