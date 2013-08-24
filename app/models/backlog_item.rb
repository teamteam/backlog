class BacklogItem < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }
  validates :name, presence: true
end
