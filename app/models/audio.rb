class Audio < ActiveRecord::Base
  attr_accessible :title, :description, :uuid

  has_many :replies, as: :item, dependent: :destroy
  has_one :ownership, as: :item, dependent: :destroy

  validates_presence_of :uuid, :title, :description

  def audio_url_origin
    "http://#{QINIU_BUCKET_AUDIO}.qiniudn.com/#{uuid}"
  end

  ["wav","mp3","m3u8"].each do |format|
    ["3g","wifi"].each do |quality|
      define_method "audio_url_#{format}_#{quality}".to_sym do
        "http://#{QINIU_BUCKET_AUDIO}.qiniudn.com/#{uuid}.#{format}_#{quality}_audio"
      end
    end
  end
end
