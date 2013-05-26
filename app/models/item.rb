class Item < ActiveRecord::Base
  attr_accessible :description, :pic_uuid, :title, :url, :news_id

  belongs_to :news


  validates_presence_of :title, :pic_uuid#, :description

  mount_uploader :pic, LocalImageUploader 
  #validates_presence_of :pic, if: Proc.new { |n|
  #  n.new_record?
  #}

  def pic_url
    if pic_uuid
      "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}-small"
    elsif pic
      pic.respond_to?(:url) ? pic.url : nil
    else
      nil
    end
  end
end
