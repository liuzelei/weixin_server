class Hd::Ggk < ActiveRecord::Base
  attr_accessible :description, :max_luck, :max_random, :pic_uuid, :title, :url


  has_many :replies, as: :item, dependent: :destroy
  has_one :ownership, as: :item, dependent: :destroy

  has_many :ggk_histories, class_name: "Hd::GgkHistory"

  validates_presence_of :max_luck, :max_random, :pic_uuid, :title

  def safe_url
    url.present? ? url : "#nogo"
  end
  def pic_url_origin
    if pic_uuid
      "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}"
    else
      nil
    end
  end
  def pic_url
    if pic_uuid
      "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}-large"
    else
      nil
    end
  end
end

