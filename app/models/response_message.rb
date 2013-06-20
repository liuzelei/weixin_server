# encoding: utf-8
class ResponseMessage < ActiveRecord::Base
  attr_accessible :content, :weixin_user_id, :request_message_id

  belongs_to :request_message
  belongs_to :weixin_user

  has_one :reply, as: :target, dependent: :destroy
  ItemTypes = ["ReplyText","News","Audio"]
  ItemTypes.each do |item_type|
    has_one item_type.underscore.to_sym, through: :reply, source: "item", source_type: item_type
  end
  #has_one :ownership, as: :item, dependent: :destroy

end
