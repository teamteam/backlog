class BacklogItem < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }
  validates :name, presence: true

  def self.archived
    self.where :archived => true
  end

  def self.this_week
    self.where :archived => false
  end
end
