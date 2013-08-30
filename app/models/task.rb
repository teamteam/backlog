require 'toggleable'

class Task < ActiveRecord::Base
  include Toggleable

  belongs_to :backlog_item
  validates :name, presence: true

  default_scope -> { order('created_at ASC') }
  scope :remaining, -> { where(:completed => false) }
end
