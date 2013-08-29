class Task < ActiveRecord::Base
  belongs_to :backlog_item
  validates :name, presence: true
end
