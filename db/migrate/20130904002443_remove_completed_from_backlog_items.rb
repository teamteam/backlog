class RemoveCompletedFromBacklogItems < ActiveRecord::Migration
  def change
    remove_column :backlog_items, :completed
  end
end
