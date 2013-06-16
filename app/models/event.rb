# encoding: utf-8
class Event < ActiveRecord::Base
  attr_accessible :category, :description, :pic_uuid, :title, :url

  has_many :replies, as: :item, dependent: :destroy
  has_one :ownership, as: :item, dependent: :destroy

  CategoryForSelect = [["刮刮卡","ScratchCard"]]

  has_many :scratch_cards, class_name: "Hd::ScratchCard"

  validates_presence_of :category, :description, :pic_uuid, :title

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

  def generate_activity(options={})
    activity = self.scratch_cards.new \
      weixin_user_id: options[:weixin_user_id],
      sn_code: SecureRandom.uuid

    luck = (self.max_random.to_i * 0.6).to_i
    if (max_random.to_i > 1) and (luck == Random.rand(max_random.to_i)) and (activity.class.where("prize is not null").count <= self.max_luck)
      activity.prize = "1"
    else
    end
    
    activity.save
  end
end


