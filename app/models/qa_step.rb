class QaStep < ActiveRecord::Base
  attr_accessible :keyword, :question, :priority
  has_one :ownership, as: :item, dependent: :destroy
end

