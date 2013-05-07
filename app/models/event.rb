class Event < ActiveRecord::Base
  attr_accessible :event, :user_id
  belongs_to :user

end
