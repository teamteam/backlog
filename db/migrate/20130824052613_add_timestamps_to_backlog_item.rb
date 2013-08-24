class AddTimestampsToBacklogItem < ActiveRecord::Migration
  def change
    change_table :backlog_items do |t|
      t.timestamps
    end
  end
end
