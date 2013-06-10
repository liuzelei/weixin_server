class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :ownerships
  ItemTypes = ["WeixinUser","QaStep","KeywordReply","News","Audio","ReplyText","Article","Video","Picture","Activity","Coupon","Shop","ResponseMessage","RequestMessage"]
  ItemTypes.each do |item_type|
    has_many item_type.underscore.pluralize.to_sym, through: :ownerships, source: "item", source_type: item_type
  end

  has_one :setting, dependent: :destroy

  def to_s
    self.email
  end

=begin
  ResourceTypes = ["WeixinUser","KeywordReply","News","Audio","ReplyText","Article","Video","Picture","Activity","Shop"]
  ResourceTypes.each do |item_type|
    define_method item_type.underscore.pluralize.to_sym do
      ownerships.where(item_type: item_type).includes(:item)
    end
  end
=end
end

