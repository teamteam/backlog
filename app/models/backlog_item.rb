class BacklogItem < ActiveRecord::Base
  default_scope -> { order('created_at ASC') }
  validates :name, presence: true

  scope :archived, -> { where(:archived => true).order "updated_at DESC" }
  scope :this_week, -> { where(:archived => false) }
end
