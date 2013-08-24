class AddCompletedToBacklogItems < ActiveRecord::Migration
  def change
    add_column :backlog_items, :completed, :boolean, :default => false
  end
end
