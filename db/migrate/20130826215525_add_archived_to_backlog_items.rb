class AddArchivedToBacklogItems < ActiveRecord::Migration
  def change
    add_column :backlog_items, :archived, :boolean, :default => false
  end
end
