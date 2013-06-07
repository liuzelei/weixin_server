QINIU_CONFIG = YAML.load_file("#{Rails.root}/config/qiniu.yml")[Rails.env]

Qiniu::RS.establish_connection! \
  :access_key => QINIU_CONFIG["access_key"],
  :secret_key => QINIU_CONFIG["secret_key"]


QINIU_BUCKET = QINIU_CONFIG["bucket"]
QINIU_BUCKET_AUDIO = QINIU_CONFIG["bucket_audio"]
QINIU_BUCKET_VIDEO = QINIU_CONFIG["bucket_video"]
#QINIU_UPLOAD_TOKEN = Qiniu::RS.generate_upload_token scope: QINIU_BUCKET #can not use this ,it will expire

def generate_qiniu_upload_token
  Qiniu::RS.generate_upload_token scope: QINIU_BUCKET
end
def generate_audio_upload_token
  Qiniu::RS.generate_upload_token \
    scope: QINIU_BUCKET_AUDIO,
    async_options: "avthumb/m3u8/preset/audio_32k;avthumb/wav/preset/audio_32k;avthumb/mp3/preset/audio_32k;avthumb/m3u8/preset/audio_64k;avthumb/wav/preset/audio_64k;avthumb/mp3/preset/audio_64k"
end
def generate_video_upload_token
  Qiniu::RS.generate_upload_token \
    scope: QINIU_BUCKET_VIDEO,
    async_options: "avthumb/m3u8/preset/video_16x9_150k;avthumb/m3u8/preset/video_16x9_640k;avthumb/mp4/preset/video_16x9_150k;avthumb/flv/preset/video_16x9_150k;avthumb/flv/preset/video_16x9_640k;avthumb/mp4/preset/video_16x9_640k;avthumb/ogg/preset/video_16x9_150;avthumb/ogg/preset/video_16x9_640k;avthumb/m4v/preset/video_16x9_150;avthumb/m4v/preset/video_16x9_640k;avthumb/webm/preset/video_16x9_150;avthumb/webm/preset/video_16x9_640k"
end

#QINIU_ENTRYURI = "testimages:eePG33EPxBQEYeuPbzQ8siZfi-pklcvzocOt1XPm"
#QINIU_ENCODEDENTRYURI = Base64.urlsafe_encode64 QINIU_ENTRYURI
#QINIU_UPLOAD_ACTION = "/rs-put/#{QINIU_ENCODEDENTRYURI}"
