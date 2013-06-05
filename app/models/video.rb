class Video < ActiveRecord::Base
  attr_accessible :title, :uuid

  validates_presence_of :uuid

  def video_url_origin
    "http://#{QINIU_BUCKET_VIDEO}.qiniudn.com/#{uuid}"
  end

  ["swf","m4v","ogg","mp4","flv","m3u8"].each do |format|
    ["3g","wifi"].each do |quality|
      define_method "video_url_#{format}_#{quality}".to_sym do
        "http://#{QINIU_BUCKET_VIDEO}.qiniudn.com/#{uuid}.#{format}_#{quality}_video"
      end
    end
  end
=begin
  def video_url_flv_3g
    "http://#{}.qiniudn.com/#{uuid}.flv_3g_video"
  end
  def video_url_flv_wifi
    "http://#{QINIU_BUCKET_VIDEO}.qiniudn.com/#{uuid}.flv_wifi_video"
  end
  def video_url_mp4_3g
    "http://#{QINIU_BUCKET_VIDEO}.qiniudn.com/#{uuid}.mp4_3g_video"
  end
  def video_url_mp4_wifi
    "http://#{QINIU_BUCKET_VIDEO}.qiniudn.com/#{uuid}.mp4_wifi_video"
  end
  def video_url_ogg_3g
    "http://#{QINIU_BUCKET_VIDEO}.qiniudn.com/#{uuid}.ogg_3g_video"
  end
  def video_url_ogg_wifi
    "http://#{QINIU_BUCKET_VIDEO}.qiniudn.com/#{uuid}.ogg_wifi_video"
  end
=end
end

