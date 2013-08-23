class BacklogItem < ActiveRecord::Base
  validates :name, presence: true
end
