class Task < ActiveRecord::Base
  belongs_to :backlog_item
end
