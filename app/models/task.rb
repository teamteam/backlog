class Task < ActiveRecord::Base
  belongs_to :backlog_item
  validates :name, presence: true

  scope :remaining, -> { where(:completed => false) }

  def toggle_complete
    update_attribute :completed, (not completed)
  end
end
