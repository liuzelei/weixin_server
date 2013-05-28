class Picture < ActiveRecord::Base
  attr_accessible :title, :pic_uuid

  def pic_url_origin
    "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}"
  end

  ["mobile","large","small"].each do |it|
    define_method "pic_url_#{it}".to_sym do
      "http://#{QINIU_BUCKET}.qiniudn.com/#{pic_uuid}-#{it}"
    end
  end
end
