class News < ActiveRecord::Base
  attr_accessible :description, :pic_uuid, :title, :url, :items_attributes

  has_many :items, dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true


  validates_presence_of :title, :pic_uuid#, :description

  # TODO: validate presence of image_url

  mount_uploader :pic, LocalImageUploader 
  #validates_presence_of :pic, if: Proc.new { |n|
  #  n.new_record?
  #}

  def safe_url
    url.present? ? url : "#nogo"
  end
  def pic_url_origin
    if pic_uuid
      "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}"
    elsif pic
      pic.respond_to?(:url) ? pic.url : nil
    else
      nil
    end
  end
  def pic_url
    if pic_uuid
      "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}-large"
    elsif pic
      pic.respond_to?(:url) ? pic.url : nil
    else
      nil
    end
  end
end
