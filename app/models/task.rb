class Task < ActiveRecord::Base
  belongs_to :backlog_item
  validates :name, presence: true

  default_scope -> { order('created_at ASC') }
  scope :remaining, -> { where(:completed => false) }
end
