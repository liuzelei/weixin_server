QINIU_CONFIG = YAML.load_file("#{Rails.root}/config/qiniu.yml")[Rails.env]

Qiniu::RS.establish_connection! \
  :access_key => QINIU_CONFIG["access_key"],
  :secret_key => QINIU_CONFIG["secret_key"]


QINIU_BUCKET = QINIU_CONFIG["bucket"]
QINIU_BUCKET_AUDIO = QINIU_CONFIG["bucket_audio"]
#QINIU_UPLOAD_TOKEN = Qiniu::RS.generate_upload_token scope: QINIU_BUCKET #can not use this ,it will expire

def generate_qiniu_upload_token
  Qiniu::RS.generate_upload_token scope: QINIU_BUCKET
end
def generate_audio_upload_token
  Qiniu::RS.generate_upload_token scope: QINIU_BUCKET_AUDIO
end

#QINIU_ENTRYURI = "testimages:eePG33EPxBQEYeuPbzQ8siZfi-pklcvzocOt1XPm"
#QINIU_ENCODEDENTRYURI = Base64.urlsafe_encode64 QINIU_ENTRYURI
#QINIU_UPLOAD_ACTION = "/rs-put/#{QINIU_ENCODEDENTRYURI}"
